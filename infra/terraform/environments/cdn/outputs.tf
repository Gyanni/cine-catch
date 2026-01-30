output "s3_bucket_name" {
  description = "S3 bucket name for frontend"
  value       = module.cdn.s3_bucket_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.cdn.cloudfront_distribution_id
}

output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = module.cdn.cloudfront_domain_name
}

output "website_url" {
  description = "Website URL"
  value       = module.cdn.website_url
}

# ACM 인증서 검증용 DNS 레코드
output "acm_certificate_validation_records" {
  description = "Add these CNAME records to Route 53 for certificate validation"
  value       = module.cdn.acm_certificate_validation_records
}

# Route 53 설정 안내
output "route53_setup_instructions" {
  description = "Route 53 setup instructions"
  value       = module.cdn.route53_setup_instructions
}
