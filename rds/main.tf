terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}

resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = var.secgroup_db_name
}

data "huaweicloud_vpc_subnets" "subnet" {
  status = "ACTIVE"
  tags {
    project = var.project_name
  }
}

data "huaweicloud_vpcs" "vpc" {
  status = "ACTIVE"
  tags {
    project = var.project_name
  }
}

data "huaweicloud_rds_flavors" "flavor" {
  db_type       = "PostgreSQL"
  db_version    = "13"
  instance_mode = "ha"
}

resource "huaweicloud_rds_instance" "instance" {
  name                = var.rds_instance_name
  flavor              = data.huaweicloud_rds_flavors.flavor.flavors[0].id
  ha_replication_mode = var.ha_replication_mode
  vpc_id              = var.vpc_id != "default" ? var.vpc_id : data.huaweicloud_vpcs.vpc.vpcs[*].id
  subnet_id           = var.subnet_id != "default" ? var.subnet_id : data.huaweicloud_vpc_subnets.subnet.subnets[0].id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone   = [
    var.availability_zone
  ]

  db {
    type     = var.db_type
    version  = var.db_version
    password = var.db_password
  }
  volume {
    type = var.volume_type
    size = var.volume_size
  }
  backup_strategy {
    start_time = var.backup_strategy_start_time
    keep_days  = var.backup_strategy_keep_days
  }
}