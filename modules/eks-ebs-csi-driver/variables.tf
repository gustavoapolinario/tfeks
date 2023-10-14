variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_identity_oidc_provider" {
  type        = string
  description = "The OIDC Identity provider for the cluster."
}

variable "helm_chart_version" {
  type        = string
  default     = "v1.23.1"
  description = "EBS CSI Driver Helm chart version."
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "Kubernetes namespace to deploy the EBS CSI Driver Helm chart."
}

variable "service_account_name" {
  type        = string
  default     = "ebs-csi-controller-sa"
  description = "EBS CSI Driver Service Account Name"
}
