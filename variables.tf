variable "aws_region" {
  type        = string
  description = "AWS region for all resources (ECR, ECS, ALB must match)."
  default     = "us-east-1"
}

variable "name_prefix" {
  type        = string
  description = "Short unique prefix for naming (ECR, cluster, ALB, IAM)."
  default     = "myapp"
}

variable "github_org" {
  type        = string
  description = "GitHub organization or username for OIDC trust (repo:ORG/REPO)."
}

variable "github_repo" {
  type        = string
  description = "Repository name (without org) for OIDC trust."
}

variable "github_branch" {
  type        = string
  description = "Git branch allowed to assume the GitHub Actions deploy role."
  default     = "main"
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
  default = 1
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "create_github_oidc_provider" {
  type        = bool
  description = "Create the GitHub OIDC provider in IAM. Set false if it already exists in this AWS account."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Extra tags merged into module resources."
  default     = {}
}
