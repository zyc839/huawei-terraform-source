output "kube_config" {
  value = module.cce.kube_config
  description = "CCE kube config"
}

output "elb_public_ip" {
   value = module.elb.elb_public_ip
   description = "ELB pubic ip"
}


output "elb_info" {
   value = module.elb
   description = "Elb info"
}


output "rds_private_ips" {
  value = var.rds_options.rds_switch?module.rds[0].private_ips:[]
  description = "instance private_ips"
}

#output "rds_public_ips" {
#  value = var.rds_db_type?[module.eip[2].address]:[]
#  description = "instance public_ips"
#}