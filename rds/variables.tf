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
  default = "CLOUDSSD"
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

variable "rds_flavor_db_type" {
  description = "Rds flavor db type"
  default = "PostgreSQL"
  type = string
}

variable "rds_flavor_db_version" {
  description = "Rds flavor db version"
  default = "13"
  type = string
}

variable "rds_flavor_instance_mode" {
  description = "Rds flavor instance mode"
  default = "ha"
  type = string
}

variable "rds_flavor_group_type" {
  description = "Rds flavor group type"
  default = "dedicated"
  type = string
}


variable "rds_flavor_vcpus" {
  description = "Rds flavor vcpus"
  default = 2
  type = number
}


variable "rds_flavor_memory" {
  description = "Rds flavor memory"
  default = 4
  type = number
}

variable "rds_ssl_enable" {
  description = "Rds ssl enable"
  default = false
  type = bool
}






