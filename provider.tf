provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "Test"
      # Environment = local.name
    }
  }

  # # Descomment and put the Role to create the EKS Cluster
  # assume_role {
  #   role_arn    = "arn:aws:iam::66666666:role/eks_creation_role"
  #   external_id = "eks_creation_role"
  # }
}

data "aws_eks_cluster_auth" "current" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.current.token

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   # This requires the awscli to be installed locally where Terraform is executed
  #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  # }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.current.token

    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   command     = "aws"
    #   # This requires the awscli to be installed locally where Terraform is executed
    #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    # }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  load_config_file       = false
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.current.token

  # exec {
  #   api_version = "client.authentication.k8s.io/v1beta1"
  #   command     = "aws"
  #   # This requires the awscli to be installed locally where Terraform is executed
  #   args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  # }
}


##
# If the module.eks lost his config, use the following command
##

# data "aws_eks_cluster_auth" "current" {
#   name = local.name
# }
# data "aws_eks_cluster" "cluster" {
#   name = local.name
# # }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.current.token
# }

# provider "helm" {
#   kubernetes {
#     host                   = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#     token                  = data.aws_eks_cluster_auth.current.token
#   }
# }

# provider "kubectl" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.current.token
#   apply_retry_count      = 5
#   load_config_file       = false
# }
