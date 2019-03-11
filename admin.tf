module "admin_vpc" {
	source = "infra/admin_vpc"
}

module "tenant_vpc" {
	source = "infra/tenant_vpc"
}

module "ram" {
  source = "infra/ram"
  alicloud_access_key = "${var.alicloud_access_key}"
  alicloud_secret_key = "${var.alicloud_secret_key}"
}