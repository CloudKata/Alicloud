output "security_group_id" {
  value = "${module.security-group.security_group_id}"
}

output "funding_server_ids" {
	value = "${alicloud_instance.funding.*.id}"
}

output "funding_slb_id" {
	value = "${module.slb_funding.slb_id}"
}

output "vswitch_cidrs" {
	value = "${alicloud_vswitch.vswitch.*.cidr_block}"
}