output "s3_bucket_name" {
  description = "Frontend S3 bucket name"
  value       = aws_s3_bucket.frontend.id
}

output "s3_bucket_arn" {
  description = "Frontend S3 bucket ARN"
  value       = aws_s3_bucket.frontend.arn
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.frontend.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "CloudFront hosted zone ID (for Route 53 alias)"
  value       = aws_cloudfront_distribution.frontend.hosted_zone_id
}

output "website_url" {
  description = "Website URL"
  value       = "https://${var.domain_name}"
}

# ACM 인증서 검증에 필요한 DNS 레코드 정보
output "acm_certificate_validation_records" {
  description = "DNS records to add to Route 53 for ACM certificate validation"
  value = [
    for dvo in aws_acm_certificate.frontend.domain_validation_options : {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      value  = dvo.resource_record_value
    }
  ]
}

# Route 53 설정 안내
output "route53_setup_instructions" {
  description = "Instructions for Route 53 setup"
  value       = <<-EOT

    ============================================
    Route 53 수동 설정 필요
    ============================================

    1. ACM 인증서 검증 (CNAME 레코드 추가)
       위의 'acm_certificate_validation_records' 값을 Route 53에 추가하세요.

    2. 도메인 연결 (A 레코드 추가)
       - 레코드 이름: ${var.domain_name}
       - 레코드 유형: A (별칭)
       - 별칭 대상: ${aws_cloudfront_distribution.frontend.domain_name}

       - 레코드 이름: www.${var.domain_name}
       - 레코드 유형: A (별칭)
       - 별칭 대상: ${aws_cloudfront_distribution.frontend.domain_name}

    ============================================
  EOT
}
