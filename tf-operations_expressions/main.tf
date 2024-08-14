terraform {}

#Number List
variable "num_list" {
  type    = list(number)
  default = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
}

#object lis of persons

variable "person_list" {
  type = list(object({
    fname = string
    lname = string
  }))

  default = [{
    fname = "Radhe"
    lname = "shyam"
    }, {
    fname = "shyam"
    lname = "gupta"
  }]
}


#map list

variable "map_list" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
  }
}

# calculations 

locals {
  mul   = 2 * 2
  add   = 234 + 5645
  check = local.mul != local.add

  double = [for num in var.num_list : num * 2]

  odd = [for num in var.num_list : num if num % 2 != 0]

  fname = [for person in var.person_list : person.fname]


  #working with map
  map_keys = [for key,value in var.map_list:key]


  double_map = {for key,value in var.map_list: key => value*5}
}

output "check" {
  value = local.check
}
output "double" {
  value = local.double
}
output "odd" {
  value = local.odd
}
output "fname" {
  value = local.fname
}

# working with maps

output "map_keys" {
  value = local.map_keys
}


output "double_map" {
  value  = local.double_map
}