terraform {
  required_providers {
    huaweicloud = {
      source  = "registry.terraform.io/huaweicloud/huaweicloud"
      version = ">=1.36.0"
    }
  }
}

data "huaweicloud_cce_clusters" "clusters" {
  name = "vela-cce-bb"
  # tags {
  #   project = var.project_name
  # }
  # status = "Available"
}

data "huaweicloud_vpc_subnets" "subnet" {
  name = "vela-subnet-bb"
  # tags {
  #   project = var.project_name
  # }
}

data "huaweicloud_compute_flavors" "flavor_1C1G" {
  availability_zone = var.availability_zone
  performance_type  = "normal"
  cpu_core_count    = 2
  memory_size       = 4
}


data "huaweicloud_images_image" "image" {
  architecture = "x86"
  os_version   = "CentOS 7.6 64bit"
  visibility   = "public"
  most_recent  = true
}


module "eip" {
   source = "git::github.com/owenJiao/terraform_source.git//eip"
   eip_name = var.eip_name
   eip_type = var.eip_type
   bandwidth_name = var.bandwidth_name
   project_name = var.project_name
}

resource "huaweicloud_networking_secgroup" "secgroup" {
  name        = var.secgroup_name
}

resource "huaweicloud_evs_volume" "volume" {
  name              = var.volume_name
  availability_zone = var.availability_zone
  volume_type       = var.volume_type
  size              = var.volume_size
}

resource "huaweicloud_compute_instance" "instance" {
  name               = var.instance_name
  image_id           = data.huaweicloud_images_image.image.id
  flavor_id          = data.huaweicloud_compute_flavors.flavor_1C1G.ids[0]
  security_group_ids = [huaweicloud_networking_secgroup.secgroup.id]
  availability_zone  = var.availability_zone

  network {
    uuid = data.huaweicloud_vpc_subnets.subnet.subnets[0].id
  }

  tags = {
    project = var.project_name
  }

}

resource "huaweicloud_compute_eip_associate" "associated" {
  public_ip   = module.eip.address
  instance_id = huaweicloud_compute_instance.instance.id
}

resource "huaweicloud_compute_volume_attach" "attached" {
  instance_id = huaweicloud_compute_instance.instance.id
  volume_id   = huaweicloud_evs_volume.volume.id
}

resource "huaweicloud_cce_node_attach" "attach_tok8s" {
  cluster_id = data.huaweicloud_cce_clusters.clusters.clusters[0].id
  server_id  = huaweicloud_compute_instance.instance.id
  password   = "123@jjxppp"
  os         = "CentOS 7.6"
}



