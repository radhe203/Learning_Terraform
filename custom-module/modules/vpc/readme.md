# terraform-aws-vpc

## Overview

This Terraform module creates an AWS VPC with a given CIDR block. It also creates multiple subnets (public and private), and for public subnets, it sets up an Internet Gateway (IGW) and appropriate route tables.

## Features

- Creates a VPC with a specified CIDR block
- Creates public and private subnets
- Creates an Internet Gateway (IGW) for public subnets
- Sets up route tables for public subnets

## usage

```
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "your_vpc"
    public     = true
  }
  subnet-config = {
    public_subnets = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1a"
      public     = true
    }

    private_subnets = {
      cidr_block = "10.0.2.0/24"
      az         = "ap-south-1b"
    }
  }
}

```
