###########################
## Create Management VPC ##
###########################

resource "alicloud_vpc" "vpc" {
  name       = "${var.vpc_name}"
  cidr_block = "${var.vpc_cidr}"
}

data "alicloud_regions" "current" {
  current = true
}

resource "alicloud_cen_instance_attachment" "attach" {
  instance_id              = "${var.cen_instance_id}"
  child_instance_id        = "${alicloud_vpc.vpc.id}"
  child_instance_region_id = "${data.alicloud_regions.current.regions.0.id}"
  depends_on               = ["alicloud_vpc.vpc", "module.funding"]
}

#################################################
## Add NAT Gateway for ougoing internet access ##
#################################################

resource "alicloud_nat_gateway" "nat_gateway" {
  vpc_id        = "${alicloud_vpc.vpc.id}"
  specification = "${var.natgw_spec}"
  name          = "${var.vpc_name}-natgw"
}

resource "alicloud_eip" "eip" {}

resource "alicloud_eip_association" "eip_asso" {
  allocation_id = "${alicloud_eip.eip.id}"
  instance_id   = "${alicloud_nat_gateway.nat_gateway.id}"
}

############################
## Create funding service ##
############################

module "funding" {
  source = "../../../modules/app/funding"

  vpc_id        = "${alicloud_vpc.vpc.id}"
  role_name     = "${var.role_name}"
  snat_table_id = "${alicloud_nat_gateway.nat_gateway.snat_table_ids}"
  snat_ip       = "${alicloud_eip.eip.ip_address}"

  #   pvtz_zone_id = "${var.pvtz_zone_id}"
}
