variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "cloudlaunch-static-site"
}

variable "github_owner" {
  description = "GitHub organization or username."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name."
  type        = string
}

variable "github_branch" {
  description = "Branch allowed to assume the AWS role."
  type        = string
  default     = "main"
}

variable "terraform_state_bucket" {
  description = "Globally unique bucket name for Terraform state."
  type        = string
}

variable "website_bucket_name" {
  description = "Globally unique website bucket name managed by the application stack."
  type        = string
}

variable "create_github_oidc_provider" {
  description = "Set false when this AWS account already has the GitHub OIDC provider."
  type        = bool
  default     = true
}

variable "existing_github_oidc_provider_arn" {
  description = "Existing provider ARN when create_github_oidc_provider is false."
  type        = string
  default     = ""
}
