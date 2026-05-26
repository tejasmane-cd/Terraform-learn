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

variable "container_image" {
  type        = string
  description = "Full container image URI including tag (e.g. 123.dkr.ecr.us-east-1.amazonaws.com/myapp-app:latest)."
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

variable "ecs_instance_type" {
  type        = string
  description = "EC2 instance type for ECS container instances."
}

variable "ecs_instance_desired_capacity" {
  type        = number
  description = "Desired number of EC2 instances in the ECS cluster."
}

variable "ecs_instance_min_size" {
  type = number
}

variable "ecs_instance_max_size" {
  type = number
}

variable "ecs_on_demand_base_capacity" {
  type        = number
  description = "Minimum number of on-demand instances in the mixed instances policy."
}

variable "ecs_on_demand_percentage_above_base_capacity" {
  type        = number
  description = "Percentage of additional instances launched as on-demand above the base capacity."
}

variable "ecs_spot_allocation_strategy" {
  type        = string
  description = "Spot allocation strategy for the mixed instances policy."
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
