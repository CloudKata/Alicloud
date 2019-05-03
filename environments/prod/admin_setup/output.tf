output "vpc_id" {
	value = "${alicloud_vpc.vpc.id}"
}

output "nat_gw_id" {
	value = "${alicloud_nat_gateway.default.id}"
}

output "mgmt-srv-name" {
	value = "${alicloud_instance.mgmt-srv.host_name}"
}