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


provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "random_num" {
  byte_length = 8
}

resource "aws_s3_bucket" "static" {
  bucket = "hostingstaticpage-${random_id.random_num.hex}"
}


resource "aws_s3_bucket_policy" "staticWeb" {

  bucket = aws_s3_bucket.static.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.static.id}/*"
        }
      ]
    }
  )

}



resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_object" "indexUpload" {
  bucket = aws_s3_bucket.static.bucket
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}


resource "aws_s3_object" "styleUpload" {
  bucket = aws_s3_bucket.static.bucket
  source = "./style.css"
  key    = "style.css"
  content_type = "text/css"
}

resource "aws_s3_bucket_website_configuration" "staticConfigure" {
  bucket = aws_s3_bucket.static.id

  index_document {
    suffix = "index.html"
  }
}


output "page_url" {
  value = aws_s3_bucket_website_configuration.staticConfigure.website_endpoint
}