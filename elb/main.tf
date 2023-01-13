terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}

data "huaweicloud_elb_flavors" "l7_flavors" {
  type            =  var.l7_type
  max_connections =  var.l7_max_connections
  cps             =  var.l7_cps
  bandwidth       =  var.l7_bandwidth
}

data "huaweicloud_elb_flavors" "l4_flavors" {
  type            =  var.l4_type
  max_connections =  var.l4_max_connections
  cps             =  var.l4_cps
  bandwidth       =  var.l4_bandwidth
}

data "huaweicloud_vpc_subnets" "subnet" {
  name = var.subnet_name
  # tags {
  #   project = var.project_name
  # }
}

data "huaweicloud_vpcs" "vpc" {
  name = var.vpc_name
  # tags {
  #   project = var.project_name
  # }
}

resource "random_string" "random" {
  length           = 5
  special          = false
}


resource "huaweicloud_elb_loadbalancer" "loadbalance" {
  name              = var.lb_name
  cross_vpc_backend = var.cross_vpc_backend
  vpc_id            = data.huaweicloud_vpcs.vpc.vpcs[0].id
  ipv4_subnet_id    = data.huaweicloud_vpc_subnets.subnet.subnets[0].ipv4_subnet_id
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