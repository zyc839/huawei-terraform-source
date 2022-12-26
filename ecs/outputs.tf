output "instance_id" {
    value = huaweicloud_compute_instance.instance.id
    description = "Instance Id"
}

output "instance_ip" {
    value = huaweicloud_compute_instance.instance.access_ip_v4
    description = "Instance IP"
}

