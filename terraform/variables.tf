variable "aws_region" {
  description = "AWS region for the S3 website bucket."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name used to identify project resources."
  type        = string
  default     = "cloudlaunch-static-site"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for website content."
  type        = string
}

variable "force_destroy_bucket" {
  description = "Allow Terraform to delete the website bucket when it contains objects."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to supported resources."
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
    Project   = "StaticWebsite"
  }
}
