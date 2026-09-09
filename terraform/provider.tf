locals {
  region          = "ap-south-1"
  name            = "easyshop-cluster"
  cidr_block      = "10.0.0.0/16"
  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  intra_subnets   = ["10.0.5.0/24", "10.0.6.0/24"]

  tags = {
    example = local.name
  }
}

provider "aws" {
  region = local.region
}


