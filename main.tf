terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      {
        Project   = var.name_prefix
        ManagedBy = "terraform"
      },
      var.tags,
    )
  }
}

module "vpc" {
  source = "./modules/vpc"

  name_prefix = var.name_prefix
  vpc_cidr    = var.vpc_cidr
  tags        = var.tags
}

module "alb" {
  source = "./modules/alb"

  name_prefix       = var.name_prefix
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = var.container_port
  health_check_path = var.health_check_path
  certificate_arn   = var.acm_certificate_arn
  tags              = var.tags
}

module "ecs" {
  source = "./modules/ecs"

  depends_on = [module.alb, null_resource.push_app_image]

  name_prefix           = var.name_prefix
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  aws_region            = var.aws_region
  container_image       = local.container_image
  container_port        = var.container_port
  cpu                   = var.ecs_cpu
  memory                = var.ecs_memory
  desired_count         = var.ecs_desired_count
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.security_group_id
  tags                  = var.tags
}
