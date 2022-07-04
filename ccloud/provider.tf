terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.32.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = ">= 0.13.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}
