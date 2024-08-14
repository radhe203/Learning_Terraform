variable "aws_instance_type" {

  description = "What kind of instance do you need ??"
  type        = string

  validation {
    condition     = var.aws_instance_type == "t2.micro" || var.aws_instance_type == "t3.micro"
    error_message = "you can only create t2.micro"
  }

}

# variable "root_volume_size" {
#   type    = number
#   default = 8
# }


# variable "root_volume_type" {
#   type    = string
#   default = "gp3"
# }


variable "ec2_config" {
  type = object({
    v_type = string,
    v_size = number
  })

  default = {
    v_type = "gp3"
    v_size = 8
  }
}

variable "additional_tags" {
  type = map(string)
  default = {
    type = "test"
    system = "ubuntu"
  }
}


# we can set enviroment variables in linux  so it won't ask for variables while executing main.tf 
# CMD : - export TF_VAR_aws_instance_type = t2.micro