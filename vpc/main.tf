terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}


resource "huaweicloud_vpc" "vpc" {
  name = var.vpc_name
  cidr = var.vpc_cidr
  tags = {
    project = var.project_name
  }
}

resource "huaweicloud_vpc_subnet" "subnet" {
  name       = var.subnet_name
  cidr       = var.subnet_cidr
  gateway_ip = var.subnet_gateway_ip
  vpc_id     = huaweicloud_vpc.vpc.id
  availability_zone = var.availability_zone
  primary_dns   = var.primary_dns
  secondary_dns = var.secondary_dns
  tags = {
    project = var.project_name
  }
}

resource "huaweicloud_vpc_subnet" "eni_subnet" {
  name          = var.eni_subnet_name
  cidr          = var.eni_subnet_cidr
  gateway_ip    = var.eni_subnet_gateway_ip
  vpc_id        = huaweicloud_vpc.vpc.id
  tags = {
    project = var.project_name
  }

resource "huaweicloud_vpc_route_table" "route_table" {
  name        = var.route_table_name
  vpc_id      = huaweicloud_vpc.vpc.id
  route {
    destination = var.route_destination
    type        = var.route_type
    nexthop     = var.route_nexthop
  }
}



}
