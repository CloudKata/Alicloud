
variable "need_attachment" {
	description = "To control zone attachment of vpcs"
	default     = "false"
}

variable "wait_time" {
  description = "To control zone attachment of vpcs"
  default     = "false"
}

data "alicloud_vpcs" "vpcs_ds"{
  status = "Available"
}

data "alicloud_regions" "current" {
  current = true
}

data "alicloud_cen_instances" "cen_instances_ds"{}

data "alicloud_pvtz_zones" "pvtz_zones_ds" {}

##########################################
## Wait time added for zone to be ready ##
#########################################

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 300"
  }
  count   = "${var.wait_time ? 1 : 0}"
}

#################################
## Attach VPCs to Private Zone ##
#################################

resource "alicloud_pvtz_zone_attachment" "attachment" {
  zone_id = "${data.alicloud_pvtz_zones.pvtz_zones_ds.zones.0.id}"
  vpc_ids = ["${data.alicloud_vpcs.vpcs_ds.ids}"]
  count   = "${var.need_attachment ? 1 : 0}"
  depends_on = ["null_resource.delay"]
}

################################
## ADD VPC to CEN for peering ##
################################

resource "alicloud_cen_instance_attachment" "attach" {
  count = "${length(data.alicloud_vpcs.vpcs_ds.ids)}"
  instance_id              = "${data.alicloud_cen_instances.cen_instances_ds.instances.0.id}"
  child_instance_id        = "${element(data.alicloud_vpcs.vpcs_ds.ids, count.index)}"
  child_instance_region_id = "${data.alicloud_regions.current.regions.0.id}"
  depends_on = ["alicloud_pvtz_zone_attachment.attachment"]
}

