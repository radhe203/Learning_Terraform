terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.62.0"

    }
  }
}


provider "aws" {
  region = "ap-south-1"
}


# aws ami
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]
}

output "ami" {
  value = data.aws_ami.ami.id
}

# we can use multiple pair of key and value insside tag
# security group

data "aws_security_group" "name" {
  tags = {
    type = "test"
  }
}

output "security_grp" {
  value = data.aws_security_group.name.id
}


# vpc


data "aws_vpc" "name" {
  tags = {
    Name = "default-vpc"
  }
}

output "vpc_id" {
  value = data.aws_vpc.name.id
}


# Availablity Zones

data "aws_availability_zones" "name" {
  state = "available"
}

output "zones" {
  value = data.aws_availability_zones.name
}


# Account details

data "aws_caller_identity" "name" {}

output "account_detail" {
  value = data.aws_caller_identity.name
}


# aws region

data "aws_region" "name" {}


output "account_region" {
  value = data.aws_region.name
}
