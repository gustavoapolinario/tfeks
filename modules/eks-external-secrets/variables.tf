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
  default     = "external-secret-sa"
  description = "External Secret service account name"
}

variable "helm_chart_version" {
  type        = string
  default     = "0.9.5"
  description = "External Secrets Helm chart version."
}

variable "namespace" {
  type        = string
  default     = "external-secrets"
  description = "Kubernetes namespace to deploy External Secrets Helm chart."
}

variable "parameter_store_prefix" {
  type        = string
  default     = ""
  description = "(Optional) Prefix of parameter store to allowed access"
}

variable "secret_store_namespace" {
  type        = list(string)
  description = "Namespaces to create the external secrets secret store"
}
