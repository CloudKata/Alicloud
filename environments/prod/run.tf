provider "alicloud" {}

#################################
## VPC to VPC peering with CEN ##
#################################

resource "alicloud_cen_instance" "cen" {
  name        = "vpc-peer"
  description = "Private Network Between VPCs"
}

resource "alicloud_pvtz_zone" "internal" {
    name = "domain.internal"
}


#####################################################################################################
# Creating users & policies for cloud account access and roles & policies for cloud resource access #
#####################################################################################################

module "ram" {
  source = "../../modules/infra/ram"
}

##################################################################################
# Modules to setup VPCs for administrative services and client specific services #
##################################################################################

module "admin_vpc" {
  source          = "admin_setup"
  pvtz_zone_id = "${alicloud_pvtz_zone.internal.id}"
}

module "tenant1_vpc" {
  source = "tenant1_setup"
  pvtz_zone_id = "${alicloud_pvtz_zone.internal.id}"
  role_name = "${module.ram.role_name}"
}

##############################################
# Associate CEN and Private Zone to the vpcs #
##############################################

variable "need_attachment" {}

module "vpc_association" {
  source = "../../modules/infra/vpc_association"
  need_attachment = "${var.need_attachment}"
}
