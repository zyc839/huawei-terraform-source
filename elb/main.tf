terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}

data "huaweicloud_elb_flavors" "l7_flavors" {
  type            = "L7"
  max_connections = 200000
  cps             = 2000
  bandwidth       = 50
}

data "huaweicloud_elb_flavors" "l4_flavors" {
  type            = "L4"
  max_connections = 500000
  cps             = 10000
  bandwidth       = 50
}

data "huaweicloud_vpc_subnets" "subnet" {
  # tags {
  #   project = var.project_name
  # }
  name = "huawei-vela-vpc-ucacb"
}

data "huaweicloud_vpcs" "vpc" {
  # tags {
  #   project = var.project_name
  # }
  name = "huawei-vela-subnet-ucacb"
}


resource "huaweicloud_elb_loadbalancer" "loadbalance" {
  name              = var.lb_name
  cross_vpc_backend = var.cross_vpc_backend
  vpc_id            = var.vpc_id != "" ? var.vpc_id : data.huaweicloud_vpcs.vpc.vpcs[0].id
  ipv4_subnet_id    = var.ipv4_subnet_id != "" ? var.ipv4_subnet_id : data.huaweicloud_vpc_subnets.subnet.subnets[0].ipv4_subnet_id
  l4_flavor_id = data.huaweicloud_elb_flavors.l4_flavors.ids[0]
  l7_flavor_id = data.huaweicloud_elb_flavors.l7_flavors.ids[0]
  availability_zone = [
    var.availability_zone
  ]
  iptype                = var.iptype
  bandwidth_charge_mode = var.bandwidth_charge_mode
  sharetype             = var.sharetype
  bandwidth_size        = var.bandwidth_size
}