###################################################################################################################
# Public and private DNS setup. Private Zone service should be enabled first in alicloud account from web console #
###################################################################################################################

#module "dns-public" {
# source = "infra/dns-public"
#}

#resource "alicloud_pvtz_zone" "zone" {
#   name = "example.int"
#}

#resource "alicloud_pvtz_zone_attachment" "zone-attachment" {
#    zone_id = "${alicloud_pvtz_zone.zone.id}"
#    vpc_ids = ["${module.setup_admin_vpc.vpc_id}", "${module.setup_tenant_vpc.vpc_id}"]
#    depends_on = [ "module.setup_admin_vpc", "module.setup_tenant_vpc" ]
#}

resource "alicloud_cen_instance" "cen" {
  name        = "vpc-peer"
  description = "Private Network Between VPCs"
}

#####################################################################################################
# Creating users & policies for cloud account access and roles & policies for cloud resource access #
#####################################################################################################

module "ram" {
  source              = "../../modules/ram"
  alicloud_access_key = "${var.alicloud_access_key}"
  alicloud_secret_key = "${var.alicloud_secret_key}"
}

##################################################################################
# Modules to setup VPCs for administrative services and client specific services #
##################################################################################

module "admin_vpc" {
  source          = "admin_vpc"
  cen_instance_id = "${alicloud_cen_instance.cen.id}"
}

module "tenant_vpc" {
  source = "tenant_vpc"

  # pvtz_zone_id = "${alicloud_pvtz_zone.zone.id}"
  role_name       = "${module.ram.role_name}"
  cen_instance_id = "${alicloud_cen_instance.cen.id}"
}
