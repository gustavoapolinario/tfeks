data "aws_default_tags" "tags" {}

locals {
  name = var.tfname

  aws_auth_roles = concat(
    local.auth_roles_karpenter,
    # local.auth_roles_lb,
    var.auth_roles,
    []
  )

  aws_auth_users = concat(
    var.auth_users,
    []
  )
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.1.5"

  name               = local.name
  kubernetes_version = var.kubernetes_version

  endpoint_public_access = var.cluster_endpoint_public_access

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnets
  control_plane_subnet_ids = var.private_subnets

  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_cluster_creator_admin_permissions = true

  # Fargate profiles use the cluster primary security group so these are not utilized
  create_security_group      = false
  create_node_security_group = false

  # Get version of add on using:
  # aws eks describe-addon-versions --addon-name kube-proxy
  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }


  fargate_profiles = {
    karpenter = {
      selectors = [
        { namespace = "karpenter" }
      ]
    }
    vpc-cni = {
      selectors = [
        {
          namespace = "kube-system"
          labels = {
            k8s-app = "aws-node"
          }
        }
      ]
    }
    coredns = {
      selectors = [
        {
          namespace = "kube-system"
          labels = {
            k8s-app = "kube-dns"
          }
        }
      ]
    }
  }

  tags = merge(data.aws_default_tags.tags.tags, {
    # NOTE - if creating multiple security groups with this module, only tag the
    # security group that Karpenter should utilize with the following tag
    # (i.e. - at most, only one security group should have this tag in your account)
    "karpenter.sh/discovery" = local.name
  })
}
