terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = "1.42.0"
    }
  }
}

locals {
  instance_name     = "k8s-node"
  kube_proxy_mode   = "ipvs"
}

data "huaweicloud_compute_flavors" "flavor" {
  availability_zone = var.availability_zone
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}

resource "random_string" "random" {
  length           = 5
  special          = false
}

module "vpc" {
  source = "git::github.com/owenJiao/terraform_source.git//vpc"
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
}

module "eip" {
   source = "git::github.com/owenJiao/terraform_source.git//eip"
   eip_name = format("%s-%s-%s", var.project_name, var.eip_name,lower(random_string.random.result))
   eip_type = var.eip_type
   bandwidth_name = var.bandwidth_name
   project_name = var.project_name
}

resource "huaweicloud_cce_cluster" "cce_turbo" {
  name                   = format("%s-%s-%s", var.project_name, var.cluster_name,lower(random_string.random.result))
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
  kube_proxy_mode        = local.kube_proxy_mode
  tags = {
    project = var.project_name
  }
}

# resource "huaweicloud_cce_addon" "coredns" {
#   cluster_id    = huaweicloud_cce_cluster.cce_turbo.id
#   template_name = "coredns"
#   version       = "1.23.3"
# }

# resource "huaweicloud_cce_addon" "autoscaler" {
#   cluster_id    = huaweicloud_cce_cluster.cce_turbo.id
#   template_name = "autoscaler"
#   version       = "1.23.9"
# }


# resource "huaweicloud_cce_addon" "nginx-ingress" {
#   cluster_id    = huaweicloud_cce_cluster.cce_turbo.id
#   template_name = "nginx-ingress"
#   version       = "2.1.0"
# }


data "huaweicloud_cce_addon_template" "autoscaler" {
  cluster_id = huaweicloud_cce_cluster.cce_turbo.id
  name       = "autoscaler"
  version    = "1.23.3"
}

resource "huaweicloud_cce_addon" "autoscaler" {
  cluster_id    = huaweicloud_cce_cluster.cce_turbo.id
  template_name = "autoscaler"
  version       = "1.23.3"

  values {
    basic_json  = jsonencode(jsondecode(data.huaweicloud_cce_addon_template.autoscaler.spec).basic)
    custom_json = jsonencode(merge(
      jsondecode(data.huaweicloud_cce_addon_template.autoscaler.spec).parameters.custom,
      {
        cluster_id = huaweicloud_cce_cluster.cce_turbo.id
      }
    ))
    flavor_json = jsonencode(jsondecode(data.huaweicloud_cce_addon_template.autoscaler.spec).parameters.flavor2)
  }
}

resource "huaweicloud_cce_node_pool" "node_pool" {
  cluster_id               = huaweicloud_cce_cluster.cce_turbo.id
  name                     = format("%s-%s-%s", var.project_name,local.instance_name,lower(random_string.random.result))
  os                       = "CentOS 7.6"
  initial_node_count       = 2
  flavor_id                = data.huaweicloud_compute_flavors.flavor.ids[0]
  availability_zone        = var.availability_zone
  password                 = "123@admin"
  scall_enable             = true
  min_node_count           = 2
  max_node_count           = 10
  scale_down_cooldown_time = 100
  priority                 = 1
  type                     = "vm"

  root_volume {
    size       = 40
    volumetype = "SSD"
  }
  data_volumes {
    size       = 100
    volumetype = "SSD"
  }

  tags = {
    project = var.project_name
  }

}

# resource "huaweicloud_cce_node" "node" {
#   count = var.node_count
#   cluster_id        = huaweicloud_cce_cluster.cce_turbo.id
#   name              = "${var.project_name}-${local.instance_name}-${random_string.random.result}-${count.index}"
#   flavor_id         = "s3.large.2"
#   availability_zone = var.availability_zone
#   password         = "123@jjxppp"
  
#   root_volume {
#     size       = 40
#     volumetype = "SSD"
#   }
#   data_volumes {
#     size       = 100
#     volumetype = "SSD"
#   }
# }

