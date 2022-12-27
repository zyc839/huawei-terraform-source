variable "lb_name" {
  description = "Loadbalancer name"
  default = "vela-lb"
  type = string
}

variable "cross_vpc_backend" {
  description = "Does cross vpc backend"
  default = "true"
  type = bool
}

variable "vpc_id" {
  description = "VPC id"
  type = string
}

variable "ipv4_subnet_id" {
  description = "Subnet id"
  type = string
}

variable "availability_zone" {
  description = "availability zone"
  type = string
}

variable "iptype" {
  description = "Ip type"
  default = "5_bgp"
  type = string
}

variable "bandwidth_charge_mode" {
  description = "Bandwidth charge mode"
  default = "traffic"
  type = string
}

variable "sharetype" {
  description = "Share type"
  default = "PER"
  type = string
}

variable "bandwidth_size" {
  description = "Bandwidth size"
  default = 10
  type = number
}

