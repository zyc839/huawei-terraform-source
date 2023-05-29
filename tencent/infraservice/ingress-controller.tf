resource "local_file" "ingress_controller" {
  content  = <<YAML
apiVersion: cloud.tencent.com/v1alpha1
kind: NginxIngress
metadata:
  name: nginx
spec:
  ingressClass: nginx
  service:
    annotation:
      service.cloud.tencent.com/pass-to-target: "true"
      service.kubernetes.io/service.extensiveParameters: '{"InternetAccessible":{"InternetChargeType":"TRAFFIC_POSTPAID_BY_HOUR","InternetMaxBandwidthOut":10}}'
    type: LoadBalancer
  workLoad:
    template:
      affinity: {}
      container:
        image: ccr.ccs.tencentyun.com/paas/nginx-ingress-controller:v1.1.3
        resources:
          limits:
            cpu: "0.5"
            memory: 1024Mi
          requests:
            cpu: "0.25"
            memory: 256Mi
      nodeSelector:
        cloud.tencent.com/auto-scaling-group-id: "${tencentcloud_kubernetes_node_pool.node_pool.auto_scaling_group_id}"
    type: daemonSet
YAML
  filename = "ingress_controller.yaml"

  depends_on = [
    tencentcloud_kubernetes_node_pool.node_pool,
    tencentcloud_kubernetes_addon_attachment.addon_nginx
  ]
}

resource "null_resource" "create_ingress_controller" {
  provisioner "local-exec" {
    when = create
    command = "kubectl --kubeconfig ./kube_config apply -f ./ingress_controller.yaml"
  }

  depends_on = [
    local_file.ingress_controller
  ]
}