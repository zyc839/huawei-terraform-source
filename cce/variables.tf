# -------  vpc module -------

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


# -------  eip module -------

variable "eip_name" {
  description = "EIP name"
  default = "vela-eip"
  type = string
}

variable "eip_type" {
  description = "EIP type"
  default = "5_bgp"
  type = string
}

variable "bandwidth_name" {
  description = "Bandwidth name"
  default = "vela-bw"
  type = string
}



# -------  cce  -------

variable "cluster_name" {
  description = "Cluster name"
  default = "vela-cce"
  type = string
}

variable "flavor_id" {
  description = "Flavor id"
  default = "cce.s2.small"
  type = string
}

variable "network_type" {
  description = "Network type"
  default = "eni"
  type = string
}

variable "cluster_version" {
  description = "Cluster version"
  default = "v1.23"
  type = string
}

variable "container_network_cidr" {
  description = "Container network cidr"
  default = "192.168.0.0/24"
  type = string
}

variable "service_network_cidr" {
  description = "Service network cidr"
  default = "10.247.0.0/16"
  type = string
}

# variable "node_count" {
#   description = "Node count"
#   default = 1
#   type = number
# }

