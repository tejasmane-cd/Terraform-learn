output "alb_dns_name" {
  description = "Application Load Balancer DNS name. Use http://DNS:80, https://DNS:443 (with cert), or http://DNS:3000."
  value       = module.alb.dns_name
}

output "ecr_repository_url" {
  description = "Push images here (same URI Terraform uses for the task definition :latest tag)."
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  value = module.ecr.repository_name
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecs_service_name" {
  value = module.ecs.service_name
}

output "github_actions_role_arn" {
  description = "Set as GitHub secret AWS_ROLE_TO_ASSUME for the deploy workflow."
  value       = module.github_oidc.role_arn
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
