terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}



locals {
  instance_name     = "k8s-node"
  kube_proxy_mode   = "ipvs"
  eip_count = 2
  is_rds_empty = var.rds_options!=null?true:false
}

resource "random_string" "random" {
  length           = 5
  special          = false
}


# eip
module "eip" {
   count = local.eip_count
   source = "git::github.com/zyc839/huawei-terraform-source.git//eip"
   eip_name = format("%s-%s-%s-%s", var.project_name, var.eip_name,lower(random_string.random.result),count.index)
   eip_type = var.eip_type
   bandwidth_name = format("%s-%s-%s", var.project_name, var.bandwidth_name,lower(random_string.random.result))
   project_name = var.project_name
}

# nat
module "nat" {
  source = "git::github.com/zyc839/huawei-terraform-source.git//nat"
  gw_name = format("%s-%s-%s", var.project_name, var.gw_name,lower(random_string.random.result))
  gw_type = var.gw_type
  publicip_id = module.eip[0].id
  subnet_id   = module.vpc.subnet_id
  vpc_id      = module.vpc.vpc_id
}

# vpc
module "vpc" {
  source = "git::github.com/zyc839/huawei-terraform-source.git//vpc"
  vpc_name = format("%s-%s-%s", var.project_name, var.vpc_name,lower(random_string.random.result))
  vpc_cidr = var.vpc_cidr
  subnet_name = format("%s-%s-%s", var.project_name, var.subnet_name,lower(random_string.random.result))
  subnet_cidr = var.subnet_cidr
  availability_zone = var.availability_zone
  subnet_gateway_ip = var.subnet_gateway_ip
  primary_dns = var.primary_dns
  secondary_dns = var.secondary_dns
  eni_subnet_name = format("%s-%s-%s", var.project_name, var.eni_subnet_name,lower(random_string.random.result))
  eni_subnet_cidr = var.eni_subnet_cidr
  eni_subnet_gateway_ip = var.eni_subnet_gateway_ip
  project_name = var.project_name
  route_table_name = format("%s-%s-%s", var.project_name, var.route_table_name,lower(random_string.random.result))
  route_destination = var.route_destination
  route_type = var.route_type
  route_nexthop = module.nat.nat_id
}

# cce
module "cce" {
  source = "git::github.com/zyc839/huawei-terraform-source.git//cce"
  cluster_name = format("%s-%s-%s", var.project_name, var.cluster_name,lower(random_string.random.result))
  flavor_id = var.flavor_id
  vpc_id   = module.vpc.vpc_id
  subnet_id  = module.vpc.subnet_id
  network_type = var.network_type
  eni_subnet_id          = module.vpc.eni_subnet_id
  eni_subnet_cidr        = module.vpc.eni_subnet_cidr
  eip_address            = module.eip[1].address 
  cluster_version        = var.cluster_version
  container_network_cidr = var.container_network_cidr
  service_network_cidr   = var.service_network_cidr
  autoscaler_version     = var.autoscaler_version
  node_os                  = var.node_os
  initial_node_count       = var.initial_node_count
  availability_zone        = var.availability_zone
  node_password            = var.node_password    
  min_node_count           = var.min_node_count
  max_node_count           = var.max_node_count
  scale_down_cooldown_time = var.scale_down_cooldown_time
  priority                 = var.priority
  node_type                 = var.node_type 
  root_volume_size         = var.root_volume_size
  root_volume_volumetype   = var.root_volume_volumetype
  data_volumes_size        = var.data_volumes_size
  data_volumes_volumetype  = var.data_volumes_volumetype
  project_name = var.project_name
  nodepool_flavor_id = var.nodepool_flavor_id
  elb_id = module.elb.elb_id
  elb_ip = module.elb.elb_public_ip
  #nodepool_performance_type  = var.nodepool_performance_type
  # nodepool_cpu_core_count    = var.nodepool_cpu_core_count
  # nodepool_memory_size       = var.nodepool_memory_size
}


# elb
module "elb" {
  source = "git::github.com/zyc839/huawei-terraform-source.git//elb"
  l7_type            =  var.l7_type
  l7_max_connections =  var.l7_max_connections
  l7_cps             =  var.l7_cps
  l7_bandwidth       =  var.l7_bandwidth
  l4_type            =  var.l4_type
  l4_max_connections =  var.l4_max_connections
  l4_cps             =  var.l4_cps
  l4_bandwidth       =  var.l4_bandwidth
  subnet_id        = module.vpc.ipv4_subnet_id
  vpc_id           = module.vpc.vpc_id
  lb_name            = format("%s-%s-%s", var.project_name, var.lb_name,lower(random_string.random.result))
  cross_vpc_backend  = var.cross_vpc_backend
  availability_zone  = var.availability_zone
  iptype                = var.iptype
  bandwidth_charge_mode = var.bandwidth_charge_mode
  sharetype             = var.sharetype
  bandwidth_size        = var.bandwidth_size
}

# rds
module "rds" {
  count = local.is_rds_empty?1:0
  source       = "git::github.com/zyc839/huawei-terraform-source.git//rds"
  project_name = format("%s-%s-%s", var.project_name, var.rds_options.rds_db_type, lower(random_string.random.result))
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.subnet_id
  db_type      = var.rds_options.rds_db_type
  db_version   = var.rds_options.rds_db_version
  rds_instance_name = var.rds_options.rds_instance_name
  rds_sg_rule_ports = var.rds_options.rds_sg_rule_ports
  rds_flavor_vcpus  = var.rds_options.rds_flavor_vcpus
  rds_flavor_memory = var.rds_options.rds_flavor_memory
#  eip_address = module.eip[2].address
}


