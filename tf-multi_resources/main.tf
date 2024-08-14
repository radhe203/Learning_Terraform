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
  project = "project-01"
}

#task one creating a vpc and two sunets

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

resource "aws_subnet" "my-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name       = "${local.project}-subnet-${count.index}"
    Enviroment = "Production"
  }
}

output "subnet_id" {
  value = aws_subnet.my-subnet[0].id
}

# task 2 :- creating 4 ec2 ,using  per sebnet 2 ec2

# resource "aws_instance" "main" {
#   ami           = "ami-0ad21ae1d0696ad58"
#   instance_type = "t2.micro"
#   count         = 4
#   subnet_id     = element(aws_subnet.my-subnet[*].id, count.index % length(aws_subnet.my-subnet))
#   tags = {
#     Name = "${local.project}-ec2-server${count.index}"
#   }
# }


# task 3 :- creating 2 instances with diff - diff amis & subnet

# resource "aws_instance" "main-2" {
#   count = length(var.ec2_config)
#   instance_type = var.ec2_config[count.index].instance_type
#   ami =  var.ec2_config[count.index].ami
#   subnet_id = element(aws_subnet.my-subnet[*].id , count.index % length(aws_subnet.my-subnet))
#   tags = {
#     Name = "${local.project}-ec2-server${count.index}"
#   }
# }

# task 4 :- creating ec2 uing for_each


resource "aws_instance" "main-2" {
  for_each = var.ec2_map
  instance_type = each.value.instance_type
  ami =  each.value.ami
  subnet_id = element(aws_subnet.my-subnet[*].id , index(keys(var.ec2_map),each.key) % length(aws_subnet.my-subnet))
  tags = {
    Name = "${local.project}-ec2-server${each.key}"
  }
}

