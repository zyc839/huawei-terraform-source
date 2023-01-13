terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}


# data "huaweicloud_vpc_subnets" "subnet" {
#   name = var.subnet_id
#   # tags {
#   #   project = var.project_name
#   # }
# }

# data "huaweicloud_vpcs" "vpc" {
#   name = var.vpc_id
#   # tags {
#   #   project = var.project_name
#   # }
# }

resource "huaweicloud_nat_gateway" "nat" {
  name        = var.gw_name
  spec        = var.gw_type
  vpc_id      = var.vpc_id
  subnet_id   = var.subnet_id

}

resource "huaweicloud_nat_snat_rule" "snat" {
  nat_gateway_id = huaweicloud_nat_gateway.nat.id
  floating_ip_id = var.publicip_id
  subnet_id      = var.subnet_id
}



