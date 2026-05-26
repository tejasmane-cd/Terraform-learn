# ECS on EC2 — existing ECR (Terraform only)

Terraform provisions VPC, **ALB** (ports **80**, **3000**, optional **443**), and **ECS on EC2**. It uses an **existing ECR repository** (does not create ECR).

ECS runs the image:

`{your-ecr-repo-url}:{ecr_image_tag}` (default tag: `latest`).

The cluster uses a mixed EC2 Auto Scaling Group with spot and on-demand capacity for cost savings.

Optionally, on `terraform apply` you can clone [iamtejas23/zomato-clone](https://github.com/iamtejas23/zomato-clone), build, and push to that same ECR (`build_and_push_image = true`).

## Prerequisites

- **ECR repository** already exists in the target account/region (e.g. `zomato-app`).
- An image with tag `ecr_image_tag` (default `latest`) already in ECR, **or** set `build_and_push_image = true` to build/push on apply.
- AWS credentials for Terraform; for optional build: **git**, **docker**, **AWS CLI**.

## Usage

1. Copy `terraform.tfvars.example` to `terraform.tfvars` and set either **`ecr_repository_name`** or **`ecr_repository_url`** for your existing repo.

2. Apply:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Open the app:

   ```bash
   terraform output alb_dns_name
   ```

## If Terraform previously created ECR in this project

Remove the old module from state so Terraform does not try to destroy your repo when switching:

```bash
terraform state rm 'module.ecr.aws_ecr_repository.this' 2>/dev/null || true
terraform state rm 'module.ecr.aws_ecr_lifecycle_policy.this' 2>/dev/null || true
```

Or import is not needed — only drop state for resources you no longer manage here.

## Variables

| Variable | Required | Purpose |
| -------- | -------- | ------- |
| `ecr_repository_name` | no if `ecr_repository_url` is set | Existing ECR repo name |
| `ecr_repository_url`  | no if `ecr_repository_name` is set | Existing ECR repo URL |
| `ecr_image_tag` | no (default `latest`) | Tag ECS uses |
| `build_and_push_image` | no (default `false`) | Build zomato-clone and push on apply |
| `ecs_desired_count` | no (default `2`) | Number of ECS tasks to run |
| `ecs_instance_type` | no (default `t3.small`) | EC2 instance type for the ECS cluster |
| `ecs_instance_desired_capacity` | no (default `2`) | Desired EC2 instance count |
| `ecs_instance_min_size` | no (default `1`) | Minimum EC2 instance count |
| `ecs_instance_max_size` | no (default `3`) | Maximum EC2 instance count |
| `ecs_on_demand_base_capacity` | no (default `1`) | On-demand base capacity for mixed ASG |
| `ecs_on_demand_percentage_above_base_capacity` | no (default `50`) | Percentage of additional instances launched as on-demand |
| `ecs_spot_allocation_strategy` | no (default `capacity-optimized`) | Spot allocation strategy for the mixed ASG |

## Modules

| Module | Role |
| ------ | ---- |
| `modules/vpc` | VPC, subnets, NAT |
| `modules/alb` | Load balancer, listeners |
| `modules/ecs` | ECS EC2 cluster, service, task definition |

## Cleanup

```bash
terraform destroy
```

Does **not** delete your ECR repository or images (only VPC/ALB/ECS resources managed here).
