#module "dns-public" {
#	source = "infra/dns-public"
#}

#resource "alicloud_pvtz_zone" "zone" {
#   name = "example.int"
#}


#resource "alicloud_pvtz_zone_attachment" "zone-attachment" {
#    zone_id = "${alicloud_pvtz_zone.zone.id}"
#    vpc_ids = ["${module.admin_vpc.vpc_id}", "${module.tenant_vpc.vpc_id}"]
#}

module "setup_adminvpc" {
	source = "infra/admin_vpc"
}

module "setup_tenant_vpc" {
	source = "infra/tenant_vpc"
#	zone_id = "${alicloud_pvtz_zone.zone.id}"
}

module "ram" {
  source = "infra/ram"
  alicloud_access_key = "${var.alicloud_access_key}"
  alicloud_secret_key = "${var.alicloud_secret_key}"
}


