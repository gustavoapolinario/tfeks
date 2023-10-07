output "vpc_outputs" {
  value = var.all_outputs ? module.vpc : null
}

output "eks_outputs" {
  value = var.all_outputs ? module.eks : null
}

output "project_execution_role" {
  description = "Role executing the commands (could be assumed)"
  value       = data.aws_caller_identity.original.arn
}

output "project_original_role" {
  description = "Role executing the commands (without the assuming role)"
  value       = data.aws_caller_identity.current.arn
}


output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}
