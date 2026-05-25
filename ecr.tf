# Use an existing ECR repository (Terraform does not create ECR).

data "aws_ecr_repository" "app" {
  count = var.ecr_repository_url == "" ? 1 : 0
  name  = var.ecr_repository_name
}

locals {
  ecr_repository_url = var.ecr_repository_url != "" ? var.ecr_repository_url : data.aws_ecr_repository.app[0].repository_url
  container_image    = "${local.ecr_repository_url}:${var.ecr_image_tag}"
}
