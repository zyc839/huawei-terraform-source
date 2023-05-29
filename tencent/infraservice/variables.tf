variable "name" {
  default = "kube-provision-clusterv1"
  type    = string
}

variable "availability_zone" {
  description = "The availability zone within which the subnet should be created."
  default     = "ap-beijing-6"
  type        = string
}

variable "region_code" {
  default = "bj"
  type    = string
}

variable "env_name" {
  default = "nonprod"
  type    = string
}

variable "k8s_version" {
  description = "Version of the cluster"
  default     = "1.22.5"
}

variable "vpc_cidr" {
  description = "A network address block which should be a subnet of the three internal network segments (10.0.0.0/16, 172.16.0.0/12 and 192.168.0.0/16)."
  default     = "10.1.0.0/16"
  type        = string
}

variable "cluster_cidr" {
  description = "A network address block of the cluster. Different from vpc cidr and cidr of other clusters within this vpc. Must be in 10./192.168/172.[16-31] segments."
  # cidr for pod/service etc
  # ip for node is within the vpc
  # max pod per node 256
  # max services 2048
  # max nodes 248
  default     = "192.168.0.0/16"
}

variable "default_instance_type" {
  description = "Specified types of CVM instance."
  default     = "SA2.MEDIUM2"
}

variable "cidr_block" {
  description = "Subnet CIDR block"
  default = "172.16.0.0/24"
  type = string
}

variable "password" { 
  default = "Default@pass1"
}




#-------rds----
#variable "charset" {
#  description = "Charset of the postgresql instance"
#  default="UTF8"
#}
#
#variable "memory" {
#  description = "Memory size(GB)"
#}
#
#variable "storage" {
#  description = "Storage size(GB)"
#}
#
#variable "min_backup_start_time" {
#  default="00:00:01"
#}
#
#variable "max_backup_start_time" {
#  default="01:00:01"
#}
#
#variable "base_backup_retention_period" {
#  default="7"
#}
#
#variable "backup_period" {
#  default=["saturday", "sunday"]
#}

#variable "charge_type" {
#  description = "Pay type of the postgresql instance"
#  default= "POSTPAID_BY_HOUR"
#}

#variable "engine_version" {
#  description = "Version of the postgresql database engine"
#  default="10.4"
#}
#variable "password" {
#  default = "Default@pass1"
#}

#
#variable "root_user" {
#  description = "Instance root user name"
#  default="postgresuser"
#}
#variable "password" {
#  default = "Default@pass1"
#}

variable "rds_options" {
  type = object({
    rds_switch = bool
    root_user = string
    password = string
    charge_type = string
    engine_version = string
    charset = string
    memory = number
    storage = number
    min_backup_start_time = string
    max_backup_start_time = string
    base_backup_retention_period = string
    backup_period = list(string)
  })
  default = {
    rds_switch = false
    root_user = "postgresuser"
    password = "Default@pass1"
    charge_type = "POSTPAID_BY_HOUR"
    engine_version = "10.4"
    charset = "UTF8"
    memory = 2
    storage = 10
    min_backup_start_time = "00:00:01"
    max_backup_start_time = "01:00:01"
    base_backup_retention_period = "7"
    backup_period = ["sunday"]
  }
}