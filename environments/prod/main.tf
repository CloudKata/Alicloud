provider "alicloud" {}

#################################
## VPC to VPC peering with CEN ##
#################################

resource "alicloud_cen_instance" "cen" {
  name        = "vpc-peer"
  description = "Private Network Between VPCs"
}

module "private-dns" {
  source = "../../modules/infra/private-dns"
  need_attachment = true
  vpc_id_list = ["${module.admin_vpc.vpc_id}", "${module.tenant_vpc.vpc_id}"]
  
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
  source          = "admin_vpc"
  cen_instance_id = "${alicloud_cen_instance.cen.id}"
  pvtz_zone_id = "${module.private-dns.pvtz_zone_id}"
}

module "tenant_vpc" {
  source = "tenant_vpc"
  pvtz_zone_id = "${module.private-dns.pvtz_zone_id}"
  role_name = "${module.ram.role_name}"
  cen_instance_id = "${alicloud_cen_instance.cen.id}"
}

