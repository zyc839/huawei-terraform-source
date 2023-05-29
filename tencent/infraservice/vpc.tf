locals {
  vpc_region_label = "${var.env_name}-${var.region_code}"
}

# VPC
# 10.1.0.0/16
# =======================================================================================
resource "tencentcloud_vpc" "main_vpc" {
  name                 = "vpc-${local.vpc_region_label}-main"
  cidr_block           = var.vpc_cidr
}

# EIP
# =======================================================================================
resource "tencentcloud_eip" "eip_nat" {
  name = "eip-${local.vpc_region_label}"
}

# NAT
# =======================================================================================
resource "tencentcloud_nat_gateway" "nat" {
  name             = "nat-${local.vpc_region_label}"
  vpc_id           = tencentcloud_vpc.main_vpc.id
  bandwidth        = 100
  max_concurrent   = 1000000
  assigned_eip_set = [tencentcloud_eip.eip_nat.public_ip]
}

# Subnet
# =======================================================================================
# Public
# 10.1.16.0/20 -> 4096 ip
resource "tencentcloud_subnet" "public_subnet" {
  name              = "sbn-${local.vpc_region_label}-public"
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 1)
  availability_zone = var.availability_zone
  vpc_id            = tencentcloud_vpc.main_vpc.id
  route_table_id    = tencentcloud_route_table.public_rtable.id
}

# Protected
# 10.1.32.0/20 -> 4096 ip
resource "tencentcloud_subnet" "protected_subnet" {
  name              = "sbn-${local.vpc_region_label}-protected"
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 2)
  availability_zone = var.availability_zone
  vpc_id            = tencentcloud_vpc.main_vpc.id
  route_table_id    = tencentcloud_route_table.protected_rtable.id
}


# Private
# 10.1.48.0/20 -> 4096 ip
resource "tencentcloud_subnet" "private_subnet" {
  name              = "sbn-${local.vpc_region_label}-private"
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, 3)
  availability_zone = var.availability_zone
  vpc_id            = tencentcloud_vpc.main_vpc.id
  route_table_id    = tencentcloud_route_table.private_rtable.id
}

# ROUTE TABLES
# ==============================================================
# Public RT
resource "tencentcloud_route_table" "public_rtable" {
  name   = "rtb-${local.vpc_region_label}-public"
  vpc_id = tencentcloud_vpc.main_vpc.id
}

# Protected RT
resource "tencentcloud_route_table" "protected_rtable" {
  name   = "rtb-${local.vpc_region_label}-protected"
  vpc_id = tencentcloud_vpc.main_vpc.id
}

# Private RT
resource "tencentcloud_route_table" "private_rtable" {
  name   = "rtb-${local.vpc_region_label}-private"
  vpc_id = tencentcloud_vpc.main_vpc.id
}

# ROUTE ENTRIES
# By default, there should be an entry for internal communication
# ==============================================================
resource "tencentcloud_route_table_entry" "protected_nat" {
  route_table_id         = tencentcloud_route_table.protected_rtable.id
  destination_cidr_block = "0.0.0.0/0"
  next_type              = "NAT"
  next_hub               = tencentcloud_nat_gateway.nat.id
}

resource "tencentcloud_route_table_entry" "private_nat" {
  route_table_id         = tencentcloud_route_table.private_rtable.id
  destination_cidr_block = "0.0.0.0/0"
  next_type              = "NAT"
  next_hub               = tencentcloud_nat_gateway.nat.id
}