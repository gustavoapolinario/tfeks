data "aws_ecrpublic_authorization_token" "token" {
  provider = aws.virginia
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {
  name   = basename(path.cwd)
  region = "us-east-1"

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/terraform-aws-eks-blueprints"
  }
}

module "vpc" {
  source = "./modules/vpc"

  tfname = local.name
  cidr = var.cidr
  create_subnet_public = var.create_subnet_public
  create_subnet_private = var.create_subnet_private
  create_nat_gateway = var.create_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  create_subnet_data = var.create_subnet_data

  azs = slice(data.aws_availability_zones.available.names, 0, var.qtt_az)
}


# ################################################################################
# # Cluster
# ################################################################################

# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 19.16"

#   cluster_name                   = local.name
#   cluster_version                = "1.27"

#   # @TODO: Change to private after PHP be created
#   cluster_endpoint_public_access = true     

#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets

#   manage_aws_auth_configmap = true
#   aws_auth_roles = [
#     # We need to add in the Karpenter node IAM role for nodes launched by Karpenter
#     {
#       rolearn  = module.eks_blueprints_addons.karpenter.node_iam_role_arn
#       username = "system:node:{{EC2PrivateDNSName}}"
#       groups = [
#         "system:bootstrappers",
#         "system:nodes",
#       ]
#     },
#   ]

#   # fargate_profiles = {
#   #   karpenter = {
#   #     selectors = [
#   #       { namespace = "karpenter" }
#   #     ]
#   #   }
#   #   kube_system = {
#   #     name = "kube-system"
#   #     selectors = [
#   #       { namespace = "kube-system" }
#   #     ]
#   #   }
#   # }

#   tags = merge(local.tags, {
#     # NOTE - if creating multiple security groups with this module, only tag the
#     # security group that Karpenter should utilize with the following tag
#     # (i.e. - at most, only one security group should have this tag in your account)
#     "karpenter.sh/discovery" = local.name
#   })
# }

# ################################################################################
# # EKS Blueprints Addons
# ################################################################################

# module "eks_blueprints_addons" {
#   source  = "aws-ia/eks-blueprints-addons/aws"
#   version = "~> 1.0"

#   cluster_name      = module.eks.cluster_name
#   cluster_endpoint  = module.eks.cluster_endpoint
#   cluster_version   = module.eks.cluster_version
#   oidc_provider_arn = module.eks.oidc_provider_arn

#   # We want to wait for the Fargate profiles to be deployed first
#   create_delay_dependencies = [for prof in module.eks.fargate_profiles : prof.fargate_profile_arn]

#   eks_addons = {
#     coredns = {
#       configuration_values = jsonencode({
#         computeType = "Fargate"
#         # Ensure that the we fully utilize the minimum amount of resources that are supplied by
#         # Fargate https://docs.aws.amazon.com/eks/latest/userguide/fargate-pod-configuration.html
#         # Fargate adds 256 MB to each pod's memory reservation for the required Kubernetes
#         # components (kubelet, kube-proxy, and containerd). Fargate rounds up to the following
#         # compute configuration that most closely matches the sum of vCPU and memory requests in
#         # order to ensure pods always have the resources that they need to run.
#         resources = {
#           limits = {
#             cpu = "0.25"
#             # We are targetting the smallest Task size of 512Mb, so we subtract 256Mb from the
#             # request/limit to ensure we can fit within that task
#             memory = "256M"
#           }
#           requests = {
#             cpu = "0.25"
#             # We are targetting the smallest Task size of 512Mb, so we subtract 256Mb from the
#             # request/limit to ensure we can fit within that task
#             memory = "256M"
#           }
#         }
#       })
#     }
#     vpc-cni    = {}
#     kube-proxy = {}
#   }

#   enable_karpenter = true
#   karpenter = {
#     repository_username = data.aws_ecrpublic_authorization_token.token.user_name
#     repository_password = data.aws_ecrpublic_authorization_token.token.password
#   }

#   tags = local.tags
# }

# ################################################################################
# # Karpenter
# ################################################################################

# resource "kubectl_manifest" "karpenter_provisioner" {
#   yaml_body = <<-YAML
#     apiVersion: karpenter.sh/v1alpha5
#     kind: Provisioner
#     metadata:
#       name: default
#     spec:
#       requirements:
#         - key: "karpenter.k8s.aws/instance-category"
#           operator: In
#           values: ["c", "m"]
#         - key: "karpenter.k8s.aws/instance-cpu"
#           operator: In
#           values: ["8", "16", "32"]
#         - key: "karpenter.k8s.aws/instance-hypervisor"
#           operator: In
#           values: ["nitro"]
#         - key: "topology.kubernetes.io/zone"
#           operator: In
#           values: ${jsonencode(local.azs)}
#         - key: "kubernetes.io/arch"
#           operator: In
#           values: ["arm64", "amd64"]
#         - key: "karpenter.sh/capacity-type" # If not included, the webhook for the AWS cloud provider will default to on-demand
#           operator: In
#           values: ["spot", "on-demand"]
#       kubeletConfiguration:
#         containerRuntime: containerd
#         maxPods: 110
#       limits:
#         resources:
#           cpu: 1000
#       consolidation:
#         enabled: true
#       providerRef:
#         name: default
#       ttlSecondsUntilExpired: 604800 # 7 Days = 7 * 24 * 60 * 60 Seconds
#   YAML

#   depends_on = [
#     module.eks_blueprints_addons
#   ]
# }

# resource "kubectl_manifest" "karpenter_node_template" {
#   yaml_body = <<-YAML
#     apiVersion: karpenter.k8s.aws/v1alpha1
#     kind: AWSNodeTemplate
#     metadata:
#       name: default
#     spec:
#       subnetSelector:
#         karpenter.sh/discovery: ${module.eks.cluster_name}
#       securityGroupSelector:
#         karpenter.sh/discovery: ${module.eks.cluster_name}
#       instanceProfile: ${module.eks_blueprints_addons.karpenter.node_instance_profile_name}
#       tags:
#         karpenter.sh/discovery: ${module.eks.cluster_name}
#   YAML
# }

# # Example deployment using the [pause image](https://www.ianlewis.org/en/almighty-pause-container)
# # and starts with zero replicas
# resource "kubectl_manifest" "karpenter_example_deployment" {
#   yaml_body = <<-YAML
#     apiVersion: apps/v1
#     kind: Deployment
#     metadata:
#       name: inflate
#     spec:
#       replicas: 0
#       selector:
#         matchLabels:
#           app: inflate
#       template:
#         metadata:
#           labels:
#             app: inflate
#         spec:
#           terminationGracePeriodSeconds: 0
#           containers:
#             - name: inflate
#               image: public.ecr.aws/eks-distro/kubernetes/pause:3.7
#               resources:
#                 requests:
#                   cpu: 1
#   YAML

#   depends_on = [
#     kubectl_manifest.karpenter_node_template
#   ]
# }

# ################################################################################
# # Supporting Resources
# ################################################################################

