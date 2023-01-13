output "vpc_id" {
  value = huaweicloud_vpc.vpc.id
  description = "vpc id"
}

output "subnet_id" {
    value = huaweicloud_vpc_subnet.subnet.id
    description = "subnet id"
}

output "ipv4_subnet_id" {
    value = huaweicloud_vpc_subnet.subnet.ipv4_subnet_id
    description = "subnet_subnet id"
}

output "eni_subnet_id" {
    value = huaweicloud_vpc_subnet.eni_subnet.ipv4_subnet_id
    description = "subnet id"
}

output "eni_subnet_cidr" {
    value = huaweicloud_vpc_subnet.eni_subnet.cidr
    description = "subnet id"
}
