variable "tfname" {
  description = "Tf Name. local.name value"
  type        = string
}

variable "azs" {
  description = "The list of AZ to use"
  type        = list
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "List of private Subnets"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes Version"
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "(Optional) Cluster Endpoint with public access"
  type        = bool
  default     = false
}

variable "namespaces_with_fargate" {
  description = "(Optional) Namespaces to run all pods on fargate"
}
