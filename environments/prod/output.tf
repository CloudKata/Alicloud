output "vpc_list" {
	value = ["${module.admin_vpc.vpc_id}", "${module.tenant1_vpc.vpc_id}"]
}

output "ram_users" {
	value = "${module.ram.user_names}"
}

output "ram_roles" {
	value = "${module.ram.role_name}"
}

output "admin_vpc_servers" {
	value = ["${module.admin_vpc.mgmt-srv-name}"]
}

output "tenant1_srv_names" {
	value = ["${module.tenant1_vpc.myapp1_instance_names}"]
}

output "tenant1_srv_ips" {
	value = ["${module.tenant1_vpc.myapp1_private_ips}"]
}

output "tenant1_slb_names" {
	value = ["${module.tenant1_vpc.myapp1_slb_name}"]
}

data "alicloud_pvtz_zone_records" "records_ds" {
    zone_id = "${alicloud_pvtz_zone.internal.id}"
}

output "private_dns_records" {
	value = "${data.alicloud_pvtz_zone_records.records_ds.records}"
}

data "alicloud_pvtz_zones" "pvtz_zones_ds" {
}
output "private_dns_zone" {
	value = "${data.alicloud_pvtz_zones.pvtz_zones_ds.zones}"
}
