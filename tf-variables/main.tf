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

locals {
  Name = "My-server"
  platform = "linux"
}


resource "aws_instance" "my-server" {
  ami           = "ami-0a4408457f9a03be3"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    # volume_size           = var.root_volume_size
    # volume_type           = var.root_volume_type

    volume_size = var.ec2_config.v_size
    volume_type = var.ec2_config.v_type
  }

  # tags = {
  #   Name = "my-server"
  # }

  tags = merge(var.additional_tags,{
     Name = local.Name
     platform = local.platform
  })
}


