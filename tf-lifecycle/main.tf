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


resource "aws_security_group" "main" {
  name = "my-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    # replace_triggered_by = [aws_security_group.main, aws_security_group.main.ingress] # if any changes happen in the listed resources than re create the instance

    precondition {
      condition     = aws_security_group.main.id != ""
      error_message = "security group id must not be empty"
    }

    postcondition {
      condition     = self.public_ip != ""
      error_message = "Public ip is not available"
    }
  }
}
