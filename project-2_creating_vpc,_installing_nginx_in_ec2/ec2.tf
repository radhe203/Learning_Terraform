
resource "aws_instance" "tf-server-1" {
  ami                         = "ami-0a4408457f9a03be3"
  subnet_id                   = aws_subnet.tf-public-subnet.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true


  user_data = <<-EOF

              #!/bin/bash
              sudo apt update 
              sudo apt install nginx -y
              sudo systemctl start nginx

              EOF

  tags = {
    Name : "tf-server-1"
  }
}
