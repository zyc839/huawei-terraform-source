# tencent cloud postgresql
resource "tencentcloud_postgresql_instance" "postgres" {
  count             = var.rds_options.rds_switch?1:0
  name              = "postgres-${var.name}"
  availability_zone = var.availability_zone
  charge_type       = var.rds_options.charge_type
  vpc_id            = tencentcloud_vpc.main_vpc.id
  subnet_id         = tencentcloud_subnet.private_subnet.id
  engine_version    = var.rds_options.engine_version
  root_user         = var.rds_options.root_user
  root_password     = var.rds_options.password
  charset           = var.rds_options.charset
  memory            = var.rds_options.memory
  storage           = var.rds_options.storage
  security_groups   = [tencentcloud_security_group.k8s_sg.id]
  backup_plan {
    min_backup_start_time        = var.rds_options.min_backup_start_time
    max_backup_start_time        = var.rds_options.max_backup_start_time
    base_backup_retention_period = var.rds_options.base_backup_retention_period
    backup_period                = var.rds_options.backup_period
  }
}