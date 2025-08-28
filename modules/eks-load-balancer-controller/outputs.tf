output "lb-controller-role" {
  description = "Role to Load Balancer Controller use to create and configure the load balancers"
  value       = aws_iam_role.kubernetes_alb_controller.arn
}

output "helm_loadbalancer_controller_version" {
  value = helm_release.alb_controller.version
}

output "helm_loadbalancer_controller_namespace" {
  value = helm_release.alb_controller.namespace
}

