output "alb_dns_name" {
  description = "Application Load Balancer DNS name. Use http://DNS:80, https://DNS:443 (with cert), or http://DNS:3000."
  value       = module.alb.dns_name
}

output "ecr_repository_url" {
  description = "Existing ECR repository URL (data source)."
  value       = local.ecr_repository_url
}

output "ecr_repository_name" {
  value = var.ecr_repository_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "container_image" {
  description = "Image URI used by the ECS task definition."
  value       = local.container_image
}

output "app_source_repo" {
  value = var.app_github_repo
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
