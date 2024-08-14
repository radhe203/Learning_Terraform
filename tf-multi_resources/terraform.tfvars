ec2_config = [{
  ami           = "ami-0ad21ae1d0696ad58"
  instance_type = "t2.micro"
  }, {
  ami           = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  }

]

ec2_map = {
  "ubuntu" = {
    ami           = "ami-0ad21ae1d0696ad58"
    instance_type = "t2.micro"
  },
  "amazon-linux" = {
    ami           = "ami-0a4408457f9a03be3"
    instance_type = "t2.micro"
  }
}
