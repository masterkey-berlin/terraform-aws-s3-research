terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Überprüfe die aktuell empfohlene Version
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}