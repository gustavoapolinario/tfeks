aws_region = "us-east-1"

# VPC
cidr = "10.0.0.0/16"
qtt_az = 3
create_subnet_public = true
create_subnet_private = true
create_nat_gateway = true
one_nat_gateway_per_az = false
create_subnet_data = true

# EKS
cluster_endpoint_public_access = true #only for tests, it must be private with VPN
kubernetes_version = "1.27"
namespaces_with_fargate = ["karpenter", "kube-system"]
auth_users = []
# # Ex of auth_users
# auth_users = [
#   {
#     userarn  = "arn:aws:iam::66666666666:user/user1"
#     username = "user1"
#     groups   = ["system:masters"]
#   },
#   {
#     userarn  = "arn:aws:iam::66666666666:user/user2"
#     username = "user2"
#     groups   = ["system:masters"]
#   },
# ]

# tf-backend state storage and lock
create_state_storage = false