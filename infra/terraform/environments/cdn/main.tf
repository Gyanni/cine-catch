terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "cdn" {
  source       = "../../modules/cdn"
  project_name = var.project_name
  domain_name  = var.domain_name
  environment  = var.environment
}

# GitHub Actions IAM 사용자 참조
data "aws_iam_user" "github_actions" {
  user_name = "github-actions"
}

# CDN 관련 IAM 정책
resource "aws_iam_user_policy" "github_actions_cdn" {
  name = "github-actions-cdn-policy"
  user = data.aws_iam_user.github_actions.user_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ACMPermissions"
        Effect = "Allow"
        Action = [
          "acm:RequestCertificate",
          "acm:DescribeCertificate",
          "acm:DeleteCertificate",
          "acm:ListCertificates",
          "acm:ListTagsForCertificate",
          "acm:AddTagsToCertificate"
        ]
        Resource = "*"
      },
      {
        Sid    = "CloudFrontPermissions"
        Effect = "Allow"
        Action = [
          "cloudfront:CreateOriginAccessControl",
          "cloudfront:GetOriginAccessControl",
          "cloudfront:UpdateOriginAccessControl",
          "cloudfront:DeleteOriginAccessControl",
          "cloudfront:CreateDistribution",
          "cloudfront:GetDistribution",
          "cloudfront:UpdateDistribution",
          "cloudfront:DeleteDistribution",
          "cloudfront:TagResource",
          "cloudfront:ListTagsForResource"
        ]
        Resource = "*"
      },
      {
        Sid    = "S3BucketPermissions"
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:GetBucketVersioning",
          "s3:PutBucketVersioning",
          "s3:GetBucketPublicAccessBlock",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:DeleteBucketPolicy",
          "s3:ListBucket",
          "s3:GetBucketTagging",
          "s3:PutBucketTagging",
          "s3:GetBucketLocation"
        ]
        Resource = [
          "arn:aws:s3:::${var.project_name}-*"
        ]
      }
    ]
  })
}
