terraform {}


locals {
  value = "Namaste World"
}

variable "string_list" {
  type    = list(string)
  default = ["server1", "server2", "server3", "server2"]
}


output "output" {
  #   value = lower(local.value)
  #   value = startswith(local.value, "Namaste") # give true or false

  #   value = split(" ",local.value)
  #   value = abs(-100) #negative to positive only
  # value = length(var.string_list)
  #   value = join(" ", var.string_list)

  #   value = toset(var.string_list) # remove duplicates from list
  value = contains(var.string_list, "server3")
}
