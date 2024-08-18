terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.62.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_security_group" "main" {
  name = "my-sg"
  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  depends_on = [ aws_security_group.main ]
}