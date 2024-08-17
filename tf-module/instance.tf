module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"


  name = "single instance"

  ami = "ami-0a4408457f9a03be3"
  instance_type = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id = module.vpc.public_subnets[0]

  tags = {
    Name = "Module Project"
  }

}