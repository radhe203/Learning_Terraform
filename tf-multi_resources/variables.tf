variable "ec2_config" {
  type = list(object({
    ami           = string
    instance_type = string
  }))

  default = [{
    ami           = "ami-0ad21ae1d0696ad58"
    instance_type = "t2.micro"
    },
    {
      ami           = "ami-0a4408457f9a03be3"
      instance_type = "t2.micro"
  }]
}

variable "ec2_map" {
  type = map(object({
    ami           = string
    instance_type = string
  }))
 
}