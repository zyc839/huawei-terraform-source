output "id" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.id
}
output "kube_config" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.kube_config
}
output "kube_config_intranet" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.kube_config_intranet
}
output "certification_authority" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.certification_authority
}
output "user_name" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.user_name
}
output "cluster_external_endpoint" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.cluster_external_endpoint
}
output "pgw_endpoint" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.pgw_endpoint
}
output "security_policy" {
  value = tencentcloud_kubernetes_cluster.k8s_cluster.security_policy
}
output "auto_scaling_group_id" {
  value = tencentcloud_kubernetes_node_pool.node_pool.auto_scaling_group_id
}
output "rds_connect" {
  value = var.rds_options.rds_switch==false?"":"${tencentcloud_postgresql_instance.postgres[0].private_access_ip}:${tencentcloud_postgresql_instance.postgres[0].private_access_port}"
}