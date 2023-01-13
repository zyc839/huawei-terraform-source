output "kube_config" {
  value = module.cce.kube_config
  description = "CCE kube config"
}


output "flavor" {
  value = module.cce.flavor
}


