# sg
resource "tencentcloud_security_group" "k8s_sg" {
  name        = "${var.name}-sg"
  description = "${var.name} k8s security group"
}

# probably allocate a bastion and only allow ingress from bastion
resource "tencentcloud_security_group_lite_rule" "k8s_sg_rules" {
  security_group_id = tencentcloud_security_group.k8s_sg.id

  ingress = [
    "ACCEPT#0.0.0.0/0#ALL#ICMP",
    "ACCEPT#0.0.0.0/0#22,3389,80,443,20,21#TCP"
  ]

  egress = [
    "ACCEPT#0.0.0.0/0#ALL#ALL",
  ]
}