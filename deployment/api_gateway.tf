resource "aws_api_gateway_rest_api" "main" {
  name = var.project_name

  body = file("${path.module}/openapi/openapi.json")

  endpoint_configuration {
    types = [
      "REGIONAL"
    ]
  }
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeploy = sha256(jsonencode(aws_api_gateway_rest_api.main.body))
  }

  lifecycle {
    create_before_destroy = true
  }

}


resource "aws_api_gateway_stage" "main" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = "prod"

  variables = {
    vpcLinkId = data.aws_ssm_parameter.vpc_link.value
  }
}

resource "aws_api_gateway_method_settings" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name

  method_path = "*/*"

  settings {
    throttling_burst_limit = 100
    throttling_rate_limit  = 100

    metrics_enabled    = true
    data_trace_enabled = true
  }
}