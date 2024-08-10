
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "bucket-df61f5407c14b0659e9cbb21"
    key    = "tf-backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_subnet" "existing_subnet" {
  id = "subnet-027963e9ba0e08e1d"
}

data "aws_vpc" "existing_vpc" {
  id = "vpc-00ae89d811f981aa8"
}

resource "aws_instance" "sampleServer" {
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.existing_subnet.id

  tags = {
    Name = "manage_state_remotely"
  }
}
