output "vpc_outputs" {
  value = var.all_outputs ? module.vpc : null
}

output "eks_outputs" {
  value = var.all_outputs ? module.eks : null
}

output "eks_loadbalancer_outputs" {
  value = var.all_outputs ? module.eks_loadbalancer : null
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}
