provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "secondary"
  region = var.region_secondary
}