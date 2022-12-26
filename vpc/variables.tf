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
  default = "192.168.0.0/24"
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

variable "primary_dns" {
  description = "Primary dns"
  default = "100.125.1.250"
  type = string
}

variable "secondary_dns" {
  description = "Secondary dns"
  default = "100.125.21.250"
  type = string
}

variable "eni_subnet_name" {
  description = "ENI Subnet name"
  default = "vela-eni"
  type = string
}

variable "eni_subnet_cidr" {
  description = "ENI Subnet cidr"
  default = "192.168.2.0/24"
  type = string
}

variable "eni_subnet_gateway_ip" {
  description = "ENI Subnet gateway ip"
  default = "192.168.2.1"
  type = string
}

variable "project_name" {
  description = "Project name"
  type = string
}
