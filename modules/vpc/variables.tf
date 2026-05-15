variable "name_prefix" {
  type        = string
  description = "Short prefix for resource Name tags (letters, numbers, hyphens)."
}

variable "vpc_cidr" {
  type        = string
  description = "IPv4 CIDR for the VPC."
  default     = "10.0.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to supported resources."
  default     = {}
}
