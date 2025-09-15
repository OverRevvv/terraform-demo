terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
  backend "s3" {
    bucket = "s3sucks6969"
    key    = "states/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
}

}

provider "aws" {
  # Configuration options
   region = "us-east-1" 
}