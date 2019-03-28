resource "alicloud_cen_instance" "cen" {
  name        = "vpc-peer"
  description = "Private Network Between VPCs"
}

#####################################################################################################
# Creating users & policies for cloud account access and roles & policies for cloud resource access #
#####################################################################################################

module "ram" {
  source = "../../modules/ram"
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

  role_name       = "${module.ram.role_name}"
  cen_instance_id = "${alicloud_cen_instance.cen.id}"
}
