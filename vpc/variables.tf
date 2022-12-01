variable "vpc_name" {
  description = "Vpc name"
  default = "vela-vpc"
  type = string
}

variable "vpc_cidr" {
  description = "Vpc CIDR block"
  default = "192.168.0.0/16"
  type = string
}

variable "subnet_name" {
  description = "Subnet name"
  default = "vela-subnet"
  type = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  default = "192.168.0.0/21"
  type = string
}

variable "availability_zone" {
  description = "Availability zone"
  default = ""
  type = string
}

variable "subnet_gateway_ip" {
  description = "Subnet gateway ip"
  default = "192.168.0.1"
  type = string
}
