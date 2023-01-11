output "elb_eip_ip" {
  value = huaweicloud_elb_loadbalancer.loadbalance.ipv4_eip
  description = "Elb public ip"
}