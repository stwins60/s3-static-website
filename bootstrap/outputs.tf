output "github_terraform_role_arn" {
  value       = aws_iam_role.github_terraform.arn
  description = "Set this as the GitHub variable AWS_TERRAFORM_ROLE_ARN."
}

output "github_oidc_provider_arn" {
  value       = local.oidc_arn
  description = "GitHub OIDC provider ARN."
}

output "terraform_state_bucket" {
  value       = data.aws_s3_bucket.terraform_state.id
  description = "Set this as the GitHub variable TF_STATE_BUCKET."
}
