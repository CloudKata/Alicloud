output "security_group_id" {
  value = "${alicloud_security_group.default.id}"
}

output "funding_server_ids" {
  value = "${alicloud_instance.funding.*.id}"
}

#output "funding_slb_id" {
#  value = "${module.slb_funding.slb_id}"
#}
