output "kube_config" {
  value = huaweicloud_cce_cluster.cce_turbo.kube_config_raw
  description = "EIP id"
}

output "projects" {
  value = data.huaweicloud_identity_projects.project
  description = "project"
}

# output "flavor" {
#   value = data.huaweicloud_compute_flavors.flavor
# }




