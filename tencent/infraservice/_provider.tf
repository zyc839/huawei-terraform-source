# Implicit provider inheritance not working, this is required at module level
terraform {
  required_providers {
       kubernetes = {
           source  = "hashicorp/kubernetes"
           version = ">= 2.19.0"
       }
       tencentcloud = {
          source  = "tencentcloudstack/tencentcloud"
          version = ">=1.77.7"
       }
       kubectl = {
          source  = "gavinbunney/kubectl"
          version = ">= 1.14.0"
       }
  }
}


