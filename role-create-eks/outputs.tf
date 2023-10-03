output "eks_creation_role" {
  description = "AWS Role to Create the EKS only. It is necessary to follow the best practices and recovery access in case of lost access on RBAC"
  value       = [
    aws_iam_role.eks_creation_role.arn,
    aws_iam_role.eks_creation_role.id,
    aws_iam_role.eks_creation_role.name,
  ]
}