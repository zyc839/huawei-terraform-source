terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.9.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "./kubeconfig.json"
  }
}

locals {
  helm_chart      = "ingress-nginx"
  helm_repository = "https://kubernetes.github.io/ingress-nginx"
}

resource "helm_release" "ingress-controller" {
  name             = var.ingress_release_name
  chart            = local.helm_chart
  namespace        = var.ingress_namespace
  repository       = local.helm_repository
  version          = var.ingress_chart_version
  create_namespace = var.ingress_create_namespace
  wait             = var.ingress_wait
  timeout          = var.ingress_timeout

  set {
    name  = "controller.ingressClassResource.name"
    value = var.ingress_class_name
  }
  set {
    name  = "controller.ingressClassResource.default"
    value = var.ingress_class_is_default
  }

  set {
    name = "controller.service.loadBalancerIP"
    value = var.ingress_ip_address
  }
  
}