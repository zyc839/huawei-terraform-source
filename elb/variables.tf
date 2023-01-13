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

# variable "vpc_id" {
#   default = "0"
#   description = "VPC id"
#   type = string
# }

# variable "ipv4_subnet_id" {
#   default = "0"
#   description = "Subnet id"
#   type = string
# }

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

variable "project_name" {
  description = "Project name"
  type = string
}

variable "l7_type" {
  default = "L7"
  description = "L7 type"
  type = string
}

variable "l7_max_connections" {
  default = 200000
  description = "L7 max connections"
  type = number
}

variable "l7_cps" {
  default = 2000
  description = "L7 cps"
  type = number
}

variable "l7_bandwidth" {
  default = 50
  description = "L7 bandwidth"
  type = number
}

variable "l4_type" {
  default = "L4"
  description = "L4 type"
  type = string
}

variable "l4_max_connections" {
  default = 500000
  description = "L4 max connections"
  type = number
}

variable "l4_cps" {
  default = 10000
  description = "L4 cps"
  type = number
}

variable "l4_bandwidth" {
  default = 50
  description = "L4 bandwidth"
  type = number
}


variable "subnet_id" {
  description = "Subnet id"
  type = string
}

variable "vpc_id" {
  description = "VPC id"
  type = string
}

