project_name        = "sales-api"
region              = "us-east-1"
region_secondary    = "sa-east-1"
api_dns_name        = "api.msfidelis.com.br"
route53_hosted_zone = "Z102505525LUE9SZ7HWTY"

routing = {
  us-east-1 = 0
  sa-east-1 = 100
}