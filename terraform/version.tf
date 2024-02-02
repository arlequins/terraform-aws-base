terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.35.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  profile = var.deploy_user
  region  = var.region

  default_tags {
    tags = var.tags
  }
}

# Need to add aws provider(us-east-1) for CloudFront Metric.
provider "aws" {
  profile = var.deploy_user
  region  = "us-east-1"
  alias   = "us-east-1"

  default_tags {
    tags = var.tags
  }
}
