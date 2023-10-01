data "aws_caller_identity" "current" {}
data "aws_default_tags" "tags" {}

locals {
  create_nat = var.create_subnet_public && var.create_subnet_private && var.create_nat_gateway
  name = var.tfname
  s3_bucket_name = "${local.name}-vpc-flow-logs-${data.aws_caller_identity.current.account_id}"
  az_length = length(var.azs)
}

# Elastic IPs for Nat Gateway
resource "aws_eip" "nat" {
  count = (
      local.create_nat ?
        var.one_nat_gateway_per_az ? local.az_length : 1
      : 0
  )

  domain   = "vpc"

  tags = merge(
    { "Name" = "${local.name}-nat-gateway" },
    data.aws_default_tags.tags.tags
  )
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = var.cidr
  # ipv6_cidr = var.ipv6_cidr

  azs             =  var.azs
  public_subnets  =  var.create_subnet_public  ? [for k, v in var.azs : cidrsubnet(var.cidr, 4, k)] : null
  private_subnets =  var.create_subnet_private ? [for k, v in var.azs : cidrsubnet(var.cidr, 4, k + 3)] : null
  database_subnets = var.create_subnet_data    ? [for k, v in var.azs : cidrsubnet(var.cidr, 4, k + 6)] : null
  public_subnet_ipv6_prefixes  = [for i in range(1, local.az_length + 1) : i]
  private_subnet_ipv6_prefixes = [for i in range(4, local.az_length + 4) : i]
  database_subnet_ipv6_prefixes = [for i in range(7, local.az_length + 7) : i]

  create_database_subnet_group = true
  create_database_subnet_route_table = true

  enable_nat_gateway =     local.create_nat
  single_nat_gateway =     var.one_nat_gateway_per_az ? false : true
  one_nat_gateway_per_az = var.one_nat_gateway_per_az ? true : false

  reuse_nat_ips       = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"

  # @TODO: export the tags
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  # @TODO: export the tags
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "karpenter.sh/discovery" = local.name # Tags subnets for Karpenter auto-discovery
  }


  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_ipv6 = true
  public_subnet_assign_ipv6_address_on_creation = true
  create_egress_only_igw = true

  # # Flow logs
  # vpc_flow_log_tags = local.tags
  # enable_flow_log           = var.enable_flow_log ? true : false
  # flow_log_file_format = var.enable_flow_log ? "parquet" : null
  # flow_log_destination_type = "s3"
  # flow_log_destination_arn  = module.s3_bucket.flow_logs.s3_bucket_arn
}


# module "s3_bucket" "flow_logs" {
#   source  = "terraform-aws-modules/s3-bucket/aws"
#   version = "~> 3.0"

#   bucket        = local.s3_bucket_name
#   policy        = data.aws_iam_policy_document.flow_log_s3.json
#   force_destroy = true
  # versioning_configuration {
  #   status = "Enabled"
  # }

# }

# data "aws_iam_policy_document" "flow_log_s3" {
#   statement {
#     sid = "AWSLogDeliveryWrite"

#     principals {
#       type        = "Service"
#       identifiers = ["delivery.logs.amazonaws.com"]
#     }

#     actions = ["s3:PutObject"]

#     resources = ["arn:aws:s3:::${local.s3_bucket_name}/AWSLogs/*"]
#   }

#   statement {
#     sid = "AWSLogDeliveryAclCheck"

#     principals {
#       type        = "Service"
#       identifiers = ["delivery.logs.amazonaws.com"]
#     }

#     actions = ["s3:GetBucketAcl"]

#     resources = ["arn:aws:s3:::${local.s3_bucket_name}"]
#   }
# }
