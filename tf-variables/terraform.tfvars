aws_instance_type = "t3.micro"

ec2_config = {
  v_size = 12
  v_type = "gp3"
}

additional_tags = {
  server = "server1"
  type   = "production"
  system = "centOs"
}
