variable "secgroup_db_name" {
  description = "Secgroup db name"
  default = "vela-sg_db"
  type = string
}

variable "rds_instance_name" {
  description = "Rds instance name"
  default = "vela-rds"
  type = string
}

variable "ha_replication_mode" {
  description = "HA replication mode"
  default = "async"
  type = string
}

variable "vpc_id" {
  description = "VPC id"
  type = string
}

variable "subnet_id" {
  description = "Subnet id"
  type = string
}

variable "availability_zone" {
  description = "Availability zone"
  type = string
}

variable "db_type" {
  description = "DB type"
  default = "PostgreSQL"
  type = string
}

variable "db_version" {
  description = "DB version"
  default = "13"
  type = string
}

variable "db_password" {
  description = "DB Password"
  default = "admin"
  type = string
}

variable "volume_type" {
  description = "Volume type"
  default = "ULTRAHIGH"
  type = string
}

variable "volume_size" {
  description = "Volume size"
  default = 40
  type = number
}

variable "backup_strategy_start_time" {
  description = "Backup strategy start time"
  default = "08:00-09:00"
  type = string
}

variable "backup_strategy_keep_days" {
  description = "Backup strategy keep days"
  default = 1
  type = number
}





