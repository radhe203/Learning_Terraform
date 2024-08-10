
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

resource "random_id" "random_num" {
  byte_length = 12
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "bucket-${random_id.random_num.hex}"
}

resource "aws_s3_object" "dataUpload" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./secfiles.txt"
  key    = "mydata.txt"
}

output "random_number" {
  value = random_id.random_num.hex
}
