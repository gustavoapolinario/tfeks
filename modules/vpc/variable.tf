variable "tfname" {
  description = "Tf Name. local.name value"
  type        = string
}

variable "azs" {
  description = "The list of AZ to use"
  type        = list(any)
}

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



