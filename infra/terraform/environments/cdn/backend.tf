# Terraform state를 S3에 저장
# 주의: 이 버킷은 terraform 실행 전에 미리 생성되어 있어야 함
terraform {
  backend "s3" {
    bucket = "cine-catch-terraform-state"
    key    = "cdn/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
