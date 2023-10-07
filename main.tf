data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" { }

locals {
  name   = basename(path.cwd)
  region = data.aws_region.current.name

  azs = slice(data.aws_availability_zones.available.names, 0, var.qtt_az)

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

  azs = local.azs
}

module "eks" {
  source = "./modules/eks"

  tfname = local.name
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  kubernetes_version = var.kubernetes_version
  namespaces_with_fargate = var.namespaces_with_fargate
  auth_users = var.auth_users
  auth_roles = var.auth_roles

  azs = local.azs
}

module "eks_rbac_default_roles" {
  depends_on = [ module.eks ]
  source = "./modules/eks-rbac-default-roles"
}

module "eks_loadbalancer" {
  depends_on = [ module.eks ]
  source = "./modules/eks-load-balancer-controller"

  cluster_name = module.eks.cluster_name
  aws_region = local.region
  cluster_identity_oidc_issuer = module.eks.oidc_provider
  cluster_identity_oidc_issuer_arn = module.eks.oidc_provider_arn
  helm_chart_version = "1.4.6"
  aws_lb_controller_version = "2.6.1"
  
}
