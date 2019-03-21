###################################################################################################################
# Public and private DNS setup. Private Zone service should be enabled first in alicloud account from web console #
###################################################################################################################

#module "dns-public" {
#	source = "infra/dns-public"
#}

#resource "alicloud_pvtz_zone" "zone" {
#   name = "example.int"
#}


#resource "alicloud_pvtz_zone_attachment" "zone-attachment" {
#    zone_id = "${alicloud_pvtz_zone.zone.id}"
#    vpc_ids = ["${module.setup_admin_vpc.vpc_id}", "${module.setup_tenant_vpc.vpc_id}"]
#}


##################################################################################
# Modules to setup VPCs for administrative services and client specific services #
##################################################################################


module "setup_admin_vpc" {
	source = "infra/admin_vpc"
}

#module "setup_tenant_vpc" {
#	source = "infra/tenant_vpc"
#	zone_id = "${alicloud_pvtz_zone.zone.id}"
#  role_name = "${module.ram.role_name}"
#}


#####################################################################################################
# Creating users & policies for cloud account access and roles & policies for cloud resource access #
#####################################################################################################

module "ram" {
  source = "infra/ram"
  alicloud_access_key = "${var.alicloud_access_key}"
  alicloud_secret_key = "${var.alicloud_secret_key}"
}


