variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "container_port" {
  type        = number
  description = "Port the application container listens on (target group forwards here)."
  default     = 3000
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate ARN in this region for HTTPS (listener 443). Leave empty to skip 443."
  default     = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}
