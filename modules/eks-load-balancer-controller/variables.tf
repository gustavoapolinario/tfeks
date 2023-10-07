variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "aws_region" {
  type        = string
  description = "AWS region where secrets are stored."
}

variable "cluster_identity_oidc_issuer" {
  type        = string
  description = "The OIDC Identity issuer for the cluster."
}

variable "cluster_identity_oidc_issuer_arn" {
  type        = string
  description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account."
}

variable "service_account_name" {
  type        = string
  default     = "aws-load-balancer-controller"
  description = "ALB Controller service account name"
}

variable "helm_chart_version" {
  type        = string
  default     = "1.4.6"
  description = "ALB Controller Helm chart version."
}

variable "aws_lb_controller_version" {
  type        = string
  default     = "2.6.1"
  description = "ALB Controller Helm chart version."
}

variable "namespace" {
  type        = string
  default     = "lb-controller"
  description = "Kubernetes namespace to deploy ALB Controller Helm chart."
}

variable "settings" {
  default     = {}
  description = "Additional settings which will be passed to the Helm chart values."
}
