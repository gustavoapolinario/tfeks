output "eks_creation_role" {
  description = "AWS Role to Create the EKS only. It is necessary to follow the best practices and recovery access in case of lost access on RBAC"
  value       = [
    aws_iam_role.eks_creation_role.arn,
    aws_iam_role.eks_creation_role.id,
    aws_iam_role.eks_creation_role.name,
  ]
}

output "assume_role" {
  description = "Assume role to put on main.tf file to assume role and create the eks as this role"
  value = {
    role_arn    = "arn:aws:iam::153149144027:role/eks_creation_role"
    external_id = "eks_creation_role"
  }
}

output "auth_users" {
  description = "Auth user to put on terraform.tfvars file to give access on eks to original role"
  value = strcontains(data.aws_caller_identity.current.arn, "user") ? {
    userarn  = data.aws_caller_identity.current.arn
    username = "system:node:{{EC2PrivateDNSName}}"
    groups = [
      "system:bootstrappers",
      "system:nodes",
    ]
  }: null
}

output "auth_roles" {
  description = "Auth role to put on terraform.tfvars file to give access on eks to original role"
  value = strcontains(data.aws_caller_identity.current.arn, "role") ? {
    rolearn  = data.aws_caller_identity.current.arn
    username = "system:node:{{EC2PrivateDNSName}}"
    groups = [
      "system:bootstrappers",
      "system:nodes",
    ]
  }: null
}
