variable "instance_name" {
  description = "Instance name"
  default = "vela_ecs"
  type = string
}

variable "project_name" {
  description = "Project name"
  type = string
}

variable "availability_zone" {
  description = "Availability zone"
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

# -------------------------------
variable "secgroup_name" {
  description = "Secgroup name"
  default = "vela-sg"
  type = string
}

# --------------volume-----------

variable "volume_name" {
  description = "Volume name"
  default = "vela-volume"
  type = string
}

variable "volume_type" {
  description = "Volume type"
  default = "SSD"
  type = string
}

variable "volume_size" {
  description = "Volume size"
  default = 10
  type = number
}





