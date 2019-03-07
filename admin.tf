module "admin_vpc" {
	source = "infra/admin_vpc"
	alicloud_access_key = "${var.alicloud_access_key}"
    alicloud_secret_key = "${var.alicloud_secret_key}"
}

module "tenant_vpc" {
	source = "infra/tenant_vpc"
}