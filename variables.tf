variable "aws_region" {
  description = "AWS Region to run the EKS"
  type = string
}

variable "qtt_az" {
  description = "Number of Zones to use"
  type        = number
  default     = 3
}

###########################################
############# VPC Variables ###############
###########################################
variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ipv6_cidr" {
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length`"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = false
}

# Public subnets
variable "create_subnet_public" {
  description = "Create the public subnet?"
  type        = bool
  default     = true
}

# Private subnets
variable "create_subnet_private" {
  description = "Create the private subnet?"
  type        = bool
  default     = true
}
variable "create_nat_gateway" {
  description = "Create the Nat gateway?"
  type        = bool
  default     = false
}
variable "one_nat_gateway_per_az" {
  description = "One Nat per AZ?"
  default     = true
  type        = bool
}

# Data subnets
variable "create_subnet_data" {
  description = "Create the data subnet?"
  type        = bool
  default     = true
}



###########################################
############# EKS Variables ###############
###########################################
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
