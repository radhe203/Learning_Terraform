terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = "5.62.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}


#create a vpc

resource "aws_vpc" "My-Vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "My-Vpc"
  }
}

#create a Private subnet


resource "aws_subnet" "Private-Subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.My-Vpc.id
  tags = {
    Name = "Private-subnet"
  }
}


#create a public subnet

resource "aws_subnet" "Public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.My-Vpc.id
  tags = {
    Name = "Public-subnet"
  }
}


#creating a internet gateway

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.My-Vpc.id
  tags = {
    Name = "my-igw"
  }
}

#creating a route table

resource "aws_route_table" "My-rt" {
  vpc_id = aws_vpc.My-Vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
}


#route table association

resource "aws_route_table_association" "public-association" {
  route_table_id = aws_route_table.My-rt.id
  subnet_id      = aws_subnet.Public-subnet.id
}

#creating ec2 

resource "aws_instance" "server" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  subnet_id                   = aws_subnet.Public-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "server1"
  }
}

output "public_ip" {
    value = aws_instance.server.public_ip
    description = "this is the public ip of the server"
}

output "private_ip" {
    value = aws_instance.server.private_ip
    description = "this is the private ip of the server"
}