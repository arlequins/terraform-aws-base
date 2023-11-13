terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.67.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  # TODO: need to change profile.
  profile = "default"
  region  = "ap-northeast-1"

  default_tags {
    tags = var.tags
  }
}

# Need to add aws provider(us-east-1) for CloudFront Metric.
provider "aws" {
  profile = "default"
  region  = "us-east-1"
  alias   = "us-east-1"

  default_tags {
    tags = var.tags
  }
}
