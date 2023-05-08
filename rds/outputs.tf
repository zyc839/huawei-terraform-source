output "private_ips" {
  value = huaweicloud_rds_instance.instance.private_ips
  description = "instance private_ips"
}

output "public_ips" {
  value = huaweicloud_rds_instance.instance.public_ips
  description = "instance public_ips"
}

output "flavor" {
   value = data.huaweicloud_rds_flavors.flavor.flavors
   description = "instance flavor"
}