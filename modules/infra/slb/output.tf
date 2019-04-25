output "slb_address" {
	value = "${alicloud_slb.service.address}"
}

#output "slb_id" {
#	value = "${alicloud_slb.service.id}"
#}

output "slb_name" {
	value = "${alicloud_slb.service.name}"
}
