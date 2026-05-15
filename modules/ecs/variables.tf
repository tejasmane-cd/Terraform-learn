variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "aws_region" {
  type = string
}

variable "ecr_repository_url" {
  type        = string
  description = "Full ECR URL without tag (e.g. 123.dkr.ecr.us-east-1.amazonaws.com/myrepo)."
}

variable "container_name" {
  type    = string
  default = "app"
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "target_group_arn" {
  type = string
}

variable "alb_security_group_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
