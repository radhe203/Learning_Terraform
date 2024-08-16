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


locals {
  users_data = yamldecode(file("./users.yaml")).users
  users_role_pair = flatten([for user in local.users_data : [for role in user.role : {
    username = user.username
    role     = role
  }]])
  pair = { for pair in local.users_role_pair : "${pair.username}-${pair.role}" => pair }
}

output "users" {
  value = local.users_data
}
output "users_role_pair" {
  value = local.users_role_pair
}
output "pair" {
  value = local.pair
}

#creating users

resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)
  name     = each.value
}

#password creation
resource "aws_iam_user_login_profile" "profile" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}


#policy attachment

resource "aws_iam_user_policy_attachment" "main" {
  for_each = local.pair
  user = aws_iam_user.users[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}