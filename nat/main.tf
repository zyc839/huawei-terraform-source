terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
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

resource "huaweicloud_nat_gateway" "nat" {
  name        = var.gw_name
  spec        = var.gw_type
  vpc_id      = data.huaweicloud_vpcs.vpc.vpcs[0].id
  subnet_id   = data.huaweicloud_vpc_subnets.subnet.subnets[0].id

}

resource "huaweicloud_nat_snat_rule" "snat" {
  nat_gateway_id = huaweicloud_nat_gateway.gateway.id
  floating_ip_id = var.publicip_id
  subnet_id      = data.huaweicloud_vpc_subnets.subnet.subnets[0].id
}



