output "elb_eip_ip" {
  value = huaweicloud_elb_loadbalancer.loadbalance.ipv4_eip
  description = "Elb public ip"
}

output "subnet" {
  value = data.huaweicloud_vpc_subnets.subnet
}


output "vpc" {
  value = data.huaweicloud_vpcs.vpc
}

