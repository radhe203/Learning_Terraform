#vpc id

output "vpc_id" {
  value = aws_vpc.main.id
}

locals {
  public_subnet_output = {
    for key, config in local.public_subnet : key => {
      subnet_id = aws_subnet.main[key].id
      az        = aws_subnet.main[key].availability_zone
    }
  }


  private_subnet_output = {
    for key, config in local.private_subnet : key => {
      subnet_id = aws_subnet.main[key].id
      az        = aws_subnet.main[key].availability_zone
    }
  }
}


output "public_subnet" {
  value = local.public_subnet_output
}


output "private_subnet" {
  value = local.private_subnet_output
}
