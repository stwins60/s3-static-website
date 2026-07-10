output "website_bucket_name" {
  description = "S3 bucket that stores the website files."
  value       = aws_s3_bucket.website.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID used for cache invalidations."
  value       = aws_cloudfront_distribution.website.id
}

output "cloudfront_domain_name" {
  description = "Public CloudFront hostname for the website."
  value       = aws_cloudfront_distribution.website.domain_name
}

output "website_url" {
  description = "HTTPS URL for the website."
  value       = "https://${aws_cloudfront_distribution.website.domain_name}"
}
