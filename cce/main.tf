terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}

module "vpc" {
  source = "git::github.com/owenJiao/terraform_source.git//vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
  availability_zone = var.availability_zone
  subnet_gateway_ip = var.subnet_gateway_ip
  primary_dns = var.primary_dns
  secondary_dns = var.secondary_dns
  eni_subnet_name = var.eni_subnet_name
  eni_subnet_cidr = var.eni_subnet_cidr
  eni_subnet_gateway_ip = var.eni_subnet_gateway_ip
}

module "eip" {
   source = "git::github.com/owenJiao/terraform_source.git//eip"
   eip_name = var.eip_name
   eip_type = var.eip_type
   bandwidth_name = var.bandwidth_name
}

resource "huaweicloud_cce_cluster" "cce_turbo" {
  name                   = var.cluster_name
  flavor_id              = var.flavor_id
  vpc_id                 = module.vpc.vpc_id
  subnet_id              = module.vpc.subnet_id
  container_network_type = var.network_type
  eni_subnet_id          = module.vpc.eni_subnet_id
  eni_subnet_cidr        = module.vpc.eni_subnet_cidr
  eip                    = module.eip.address
  cluster_version        = var.cluster_version
  container_network_cidr = var.container_network_cidr
  service_network_cidr   = var.service_network_cidr
}

resource "huaweicloud_cce_node" "node" {
  count = var.node_count
  cluster_id        = huaweicloud_cce_cluster.cce_turbo.id
  name              = count.index
  flavor_id         = "s3.large.2"
  availability_zone = var.availability_zone
  password         = "123456"
  
  root_volume {
    size       = 40
    volumetype = "SATA"
  }
  data_volumes {
    size       = 100
    volumetype = "SATA"
  }
}

