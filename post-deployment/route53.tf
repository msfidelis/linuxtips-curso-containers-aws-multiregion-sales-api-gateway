

resource "aws_route53_record" "primary" {
  zone_id = var.route53_hosted_zone
  name    = var.api_dns_name


  type = "A"

  weighted_routing_policy {
    weight = lookup(var.routing, var.region)
  }

  set_identifier = "primary"

  alias {
    evaluate_target_health = true
    name                   = data.aws_api_gateway_domain_name.primary.regional_domain_name
    zone_id                = data.aws_api_gateway_domain_name.primary.regional_zone_id
  }

}



resource "aws_route53_record" "secondary" {
  zone_id = var.route53_hosted_zone
  name    = var.api_dns_name


  type = "A"

  weighted_routing_policy {
    weight = lookup(var.routing, var.region_secondary)
  }

  set_identifier = "secondary"

  alias {
    evaluate_target_health = true
    name                   = data.aws_api_gateway_domain_name.secondary.regional_domain_name
    zone_id                = data.aws_api_gateway_domain_name.secondary.regional_zone_id
  }

}