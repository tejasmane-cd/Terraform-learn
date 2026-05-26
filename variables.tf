variable "aws_region" {
  type        = string
  description = "AWS region for all resources (ECR, ECS, ALB must match)."
  default     = "us-east-1"
}

variable "name_prefix" {
  type        = string
  description = "Short unique prefix for naming (cluster, ALB, IAM)."
  default     = "zomato"
}

variable "ecr_repository_name" {
  type        = string
  description = "Name of your existing ECR repository (not created by Terraform). Either this or ecr_repository_url must be provided."
  default     = ""
}

variable "ecr_repository_url" {
  type        = string
  description = "Full existing ECR repository URL, e.g. 123456789012.dkr.ecr.us-east-1.amazonaws.com/zomato-app. Use this instead of ecr_repository_name if you already have the full URI."
  default     = ""
}

variable "ecr_image_tag" {
  type        = string
  description = "Image tag in ECR for the ECS task (e.g. latest)."
  default     = "latest"
}

variable "app_github_repo" {
  type        = string
  description = "GitHub repository to clone and build (ORG/REPO)."
  default     = "iamtejas23/zomato-clone"
}

variable "app_github_ref" {
  type        = string
  description = "Git branch or tag to build from zomato-clone."
  default     = "main"
}

variable "build_and_push_image" {
  type        = bool
  description = "On apply, clone zomato-clone, docker build, and push to existing ECR (needs git, docker, aws CLI). Set false if the image is already in ECR."
  default     = false
}

variable "acm_certificate_arn" {
  type        = string
  description = "Optional ACM certificate ARN in this region for HTTPS on port 443. Leave empty to create only HTTP listeners (80 and 3000)."
  default     = ""
}

variable "container_port" {
  type        = number
  description = "Application listen port inside the container."
  default     = 3000
}

variable "health_check_path" {
  type        = string
  description = "ALB target group health check path; must return 200–399 when the app is healthy."
  default     = "/"
}

variable "ecs_cpu" {
  type    = number
  default = 256
}

variable "ecs_memory" {
  type    = number
  default = 512
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}

variable "ecs_instance_type" {
  type        = string
  description = "EC2 instance type for ECS container instances."
  default     = "t3.small"
}

variable "ecs_instance_desired_capacity" {
  type        = number
  description = "Desired number of EC2 instances in the ECS cluster."
  default     = 2
}

variable "ecs_instance_min_size" {
  type    = number
  default = 1
}

variable "ecs_instance_max_size" {
  type    = number
  default = 3
}

variable "ecs_on_demand_base_capacity" {
  type        = number
  description = "Minimum number of on-demand instances in the mixed instances policy."
  default     = 1
}

variable "ecs_on_demand_percentage_above_base_capacity" {
  type        = number
  description = "Percentage of additional instances launched as on-demand above the base capacity."
  default     = 50
}

variable "ecs_spot_allocation_strategy" {
  type        = string
  description = "Spot allocation strategy for the mixed instances policy."
  default     = "capacity-optimized"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "Extra tags merged into module resources."
  default     = {}
}
