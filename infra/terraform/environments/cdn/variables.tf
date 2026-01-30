variable "project_name" {
  description = "Project name"
  type        = string
  default     = "cine-catch"
}

variable "domain_name" {
  description = "Frontend domain name"
  type        = string
  default     = "cine-catch.com"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "prod"
}
