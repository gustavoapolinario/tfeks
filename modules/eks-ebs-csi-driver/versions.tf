terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.11"
    }
    http = {
      source  = "hashicorp/http"
      version = ">= 3.4"
    }
  }
}
