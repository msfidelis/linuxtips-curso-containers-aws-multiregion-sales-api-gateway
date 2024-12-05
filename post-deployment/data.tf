data "aws_api_gateway_domain_name" "primary" {
  domain_name = var.api_dns_name
}

data "aws_api_gateway_domain_name" "secondary" {
  provider    = aws.secondary
  domain_name = var.api_dns_name
}
