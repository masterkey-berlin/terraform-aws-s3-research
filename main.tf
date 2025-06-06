# terraform/aws-s3-research/main.tf

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Überprüfe die aktuell empfohlene Version auf der Registry-Seite
    }
  }
}

provider "aws" {
  region = "eu-central-1" # ERSETZE DIES mit deiner AWS-Region (z.B. us-east-1, eu-west-2 etc.)
  # Diese Region sollte mit deiner Default-Region aus aws configure
  # oder den Umgebungsvariablen übereinstimmen, oder sie überschreibt diese.
}

resource "aws_s3_bucket" "my_research_bucket" {
  # WICHTIG: Bucket-Namen müssen global eindeutig sein!
  # Füge deinen Namen/Initialen und ggf. eine Zufallszahl/Datum hinzu.
  bucket = "research-bucket-mh66" # ERSETZEN!

  tags = {
    Name        = "My Terraform Research Bucket"
    Environment = "Development"
    Project     = "Terraform S3 Research"
  }
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket."
  value       = aws_s3_bucket.my_research_bucket.arn
}

output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket."
  value       = aws_s3_bucket.my_research_bucket.bucket_regional_domain_name
}