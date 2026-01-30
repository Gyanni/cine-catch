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
