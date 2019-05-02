output "security_group_id" {
  value = "${alicloud_security_group.default.id}"
}

output "funding_server_ids" {
  value = "${alicloud_instance.funding.*.id}"
}

output "funding_dns_id" {
	value = "${alicloud_pvtz_zone_record.pvtz_records.id}"
}