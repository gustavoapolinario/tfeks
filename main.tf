data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {
  name   = basename(path.cwd)

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

  azs = local.azs
}

