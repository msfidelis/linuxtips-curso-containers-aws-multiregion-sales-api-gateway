variable "project_name" {}

variable "region" {}

variable "region_secondary" {}

variable "api_dns_name" {}

variable "route53_hosted_zone" {}

variable "routing" {
  type = object({
    us-east-1 = number
    sa-east-1 = number
  })
}
