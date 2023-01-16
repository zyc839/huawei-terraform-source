output "elb_public_ip" {
  value = huaweicloud_elb_loadbalancer.loadbalance.ipv4_eip
  description = "Elb public ip"
}

// How to get elb id.
# output "elb_id" {
#   value = huaweicloud_elb_loadbalancer.loadbalance.ipv4_eip
#   description = "Elb id"
# }



