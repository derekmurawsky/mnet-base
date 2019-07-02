terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

locals {
  common_tags = {
    Managed = "Terraform"
  }
}
