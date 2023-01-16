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


variable "primary_availability_zone" {
  description = "Primary availability zone"
  default = "cn-east-3a"
  type = string
}

variable "standby_availability_zone" {
  description = "Standby availability zone"
  default = "cn-east-3b"
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
  default = "123@admin"
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

variable "project_name" {
  description = "Project name"
  type = string
}

variable "vpc_id" {
  description = "vpc id"
  type = string
}

variable "subnet_id" {
  description = "Subnet id"
  type = string
}

variable "rds_flavor" {
  description = "Rds flavor"
  default = "rds.pg.x1.xlarge.8.ha"
  type = string
}





