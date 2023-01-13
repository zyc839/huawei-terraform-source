variable "gw_name" {
  description = "Gateway name"
  default = "vela-gw"
  type = string
}

variable "gw_type" {
  description = "Gateway type"
  default = 1
  type = number
}


variable "publicip_id" {
  description = "Public ip id"
  type = string
}

variable "subnet_name" {
  description = "Subnet name"
  type = string
}

variable "vpc_name" {
  description = "VPC name"
  type = string
}

