variable "vpc_config" {
  description = "Enter cCIDR block and Name of Vpc"
  type = object({
    cidr_block = string
    name       = string
    }
  )
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
  }
}



variable "subnet-config" {
  description = "get the CIDR and AZ for the subnets"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))
  validation {
    condition     = alltrue([for config in var.subnet-config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}
