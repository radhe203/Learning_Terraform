

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region = var.region
}

data "aws_vpc" "existing_vpc" {
  id = "vpc-00ae89d811f981aa8"
}

data "aws_subnet" "existing_subnet" {
  id = "subnet-027963e9ba0e08e1d"
}

resource "aws_instance" "myserver" {
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.existing_subnet.id
  tags = {
    Name = "sampleServer"
  }
}
