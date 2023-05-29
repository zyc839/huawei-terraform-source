# TKE cluster
# TODO, evaluate EKS
# network https://cloud.tencent.com/document/product/457/50353
locals {
  cluster_region_label = "${var.env_name}-${var.region_code}-${var.name}"
}

resource "tencentcloud_kubernetes_cluster" "k8s_cluster" {
  vpc_id                                     = tencentcloud_vpc.main_vpc.id
  cluster_version                            = var.k8s_version
  cluster_cidr                               = var.cluster_cidr
  cluster_max_pod_num                        = 256
  cluster_name                               = "tke-${local.cluster_region_label}"
  cluster_desc                               = "k8s main cluster"
  cluster_max_service_num                    = 2048
  cluster_internet                           = true
  #managed_cluster_internet_security_policies = ["0.0.0.0/0"] #TODO change this
  cluster_internet_security_group            = tencentcloud_security_group.k8s_sg.id
  cluster_deploy_type                        = "MANAGED_CLUSTER"
  cluster_os                                 = "ubuntu18.04.1x86_64"
  container_runtime                          = "containerd"
  network_type                               = "GR" # "VPC-CNI"
  deletion_protection                        = false # can disable from UI

  worker_config {
    instance_name              = "tke-${local.cluster_region_label}-node"
    public_ip_assigned         = false # disable public ip and access through bastion
    subnet_id                  = tencentcloud_subnet.protected_subnet.id # TODO, put it in protected subnet
    security_group_ids         = [tencentcloud_security_group.k8s_sg.id]
    availability_zone          = var.availability_zone
    instance_type              = var.default_instance_type
    system_disk_type           = "CLOUD_PREMIUM"
    system_disk_size           = 50
    # internet_max_bandwidth_out = 10 # To enable access by public CLB, this must not be zero.
    internet_charge_type       = "TRAFFIC_POSTPAID_BY_HOUR"
    enhanced_security_service  = true
    enhanced_monitor_service   = true
    password                   = var.password
  }

  depends_on = [tencentcloud_vpc.main_vpc, tencentcloud_security_group.k8s_sg]
}

# Node pool for autoscaling
resource "tencentcloud_kubernetes_node_pool" "node_pool" {
  name                 = "tke-${local.cluster_region_label}-pool"
  cluster_id           = tencentcloud_kubernetes_cluster.k8s_cluster.id
  max_size             = 2
  min_size             = 1
  vpc_id               = tencentcloud_vpc.main_vpc.id
  subnet_ids           = [tencentcloud_subnet.protected_subnet.id] # TODO, put it in protected subnet
  retry_policy         = "INCREMENTAL_INTERVALS"
  desired_capacity     = 1
  enable_auto_scale    = true
  delete_keep_instance = false
  node_os              = "ubuntu18.04.1x86_64"
  auto_scaling_config {
    instance_type      = var.default_instance_type
    system_disk_type   = "CLOUD_PREMIUM"
    system_disk_size   = "50"
    security_group_ids = [tencentcloud_security_group.k8s_sg.id]
    #data_disk {
    #  disk_type = "CLOUD_PREMIUM"
    #  disk_size = 50
    #}
    internet_charge_type       = "TRAFFIC_POSTPAID_BY_HOUR"
    # internet_max_bandwidth_out = 10
    public_ip_assigned         = false
    password                   = var.password
    enhanced_security_service  = true
    enhanced_monitor_service   = true
  }

  depends_on = [tencentcloud_vpc.main_vpc, tencentcloud_subnet.protected_subnet, tencentcloud_security_group.k8s_sg]
}

resource "tencentcloud_kubernetes_addon_attachment" "addon_nginx" {
  # Not supported on outposts
  cluster_id = tencentcloud_kubernetes_cluster.k8s_cluster.id
  name = "ingressnginx"
  request_body = <<EOF
  {
    "kind":"App",
    "spec":{
        "chart":{
            "chartName":"ingressnginx",
            "chartVersion":"1.2.0"
        }
    }
  }
EOF
  depends_on = [
    tencentcloud_kubernetes_cluster.k8s_cluster
  ]
}

resource "local_file" "private_key" {
    content  = tencentcloud_kubernetes_cluster.k8s_cluster.kube_config
    filename = "./kube_config"
}
