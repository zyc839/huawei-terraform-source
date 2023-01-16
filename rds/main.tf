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
  id = var.subnet_id
  # tags {
  #   project = var.project_name
  # }
}

data "huaweicloud_vpcs" "vpc" {
  id = var.vpc_id
  # tags {
  #   project = var.project_name
  # }
}

data "huaweicloud_rds_flavors" "flavor" {
  db_type       = "PostgreSQL"
  db_version    = "13"
  instance_mode = "ha"
  group_type = "dedicated"
  vcpus = 2
  memory = 4
}


# resource "huaweicloud_rds_instance" "instance" {
#   name                = "terraform_test_rds_instance"
#   flavor              = "rds.pg.x1.xlarge.8.ha"
#   ha_replication_mode = "async"
#   vpc_id              = "67ef1c7d-cc9d-4f50-8f30-58d9150ea5ee"
#   subnet_id           = "eb4247f1-6257-4de0-a264-36dd82d3f989"
#   security_group_id   = huaweicloud_networking_secgroup.secgroup.id
#   availability_zone   = [
#     "cn-east-3b",
#     "cn-east-3a"
#   ]

#   db {
#     type     = "PostgreSQL"
#     version  = "13"
#     password = "Huangwei!120521"
#   }

#   volume {
#     type = "CLOUDSSD"
#     size = 100
#   }
#   backup_strategy {
#     start_time = "08:00-09:00"
#     keep_days  = 1
#   }
# }



resource "huaweicloud_rds_instance" "instance" {
  name                = var.rds_instance_name
  flavor              = data.huaweicloud_rds_flavors.flavor.flavors[0].id // var.rds_flavor
  ha_replication_mode = var.ha_replication_mode
  vpc_id              = var.vpc_id // != "default" ? var.vpc_id : data.huaweicloud_vpcs.vpc.vpcs[0].id
  subnet_id           = var.subnet_id // != "default" ? var.subnet_id : data.huaweicloud_vpc_subnets.subnet.subnets[0].id
  security_group_id   = huaweicloud_networking_secgroup.secgroup.id
  availability_zone   = [
    var.primary_availability_zone,
    var.standby_availability_zone
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
  tags = {
    project = var.project_name
  }

}