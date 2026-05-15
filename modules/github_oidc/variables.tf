variable "name_prefix" {
  type = string
}

variable "github_org" {
  type        = string
  description = "GitHub organization or user that owns the repository."
}

variable "github_repo" {
  type = string
}

variable "github_branch" {
  type        = string
  description = "Branch allowed to assume the deploy role (e.g. main)."
  default     = "main"
}

variable "ecr_repository_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "create_oidc_provider" {
  type        = bool
  description = "Set false if this account already has an IAM OIDC provider for token.actions.githubusercontent.com (only one per account)."
  default     = true
}
