terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}


resource "huaweicloud_vpc_eip" "eip" {
  name = var.eip_name
  publicip {
    type = var.eip_type
  }
  bandwidth {
    share_type  = "PER"
    name        = var.bandwidth_name
    size        = 10
    charge_mode = "traffic"
  }
  tags = {
    project = var.project_name
  }
}



