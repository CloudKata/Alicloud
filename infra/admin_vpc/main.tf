# Collect Instance Types available in the vpc zone #
###################################################

data "alicloud_instance_types" "default" {
  cpu_core_count = "${var.cpu_core_count}"
  memory_size    = "${var.memory_size}"
  instance_type_family = "${var.instance_type_family}"
}

# Collect zone data #
#####################

data "alicloud_zones" main {
  available_resource_creation = "VSwitch"
  multi = true
  network_type = "Vpc"
}

# Save zone names in local variable

locals {
  vpc_azs = "${data.alicloud_zones.main.zones.0.id}, ${data.alicloud_zones.main.zones.1.id}"
}

# Create Management VPC #
#########################

module "vpc" {
   source = "alibaba/vpc/alicloud"
   version = "1.1.0"
   
   vpc_name = "${var.vpc_name}"
   vpc_description = "${var.vpc_name}"
   vpc_cidr = "${var.vpc_cidr}"
   
   availability_zones = "${var.vpc_azs}"

}

# Create vswitch #
##################

resource "alicloud_vswitch" "vswitch" {
  count = "${length(var.vswitch_cidrs)}"
  vpc_id = "${module.vpc.vpc_id}"
  name = "${format("vsw-%s-%02d", var.vpc_name, count.index + 1)}"
  cidr_block = "${var.vswitch_cidrs[count.index]}"
  availability_zone = "${element(split(", ", local.vpc_azs), count.index)}"
}

# Create Management Security Group #
####################################

module "security-group" {
  source = "alibaba/security-group/alicloud"

  vpc_id = "${module.vpc.vpc_id}"
  group_name = "sg-${var.vpc_name}"
  rule_directions = ["ingress"]
  ip_protocols = ["tcp", "tcp", "tcp"]
  policies = ["accept", "accept"]
  port_ranges = "${var.sg_port_ranges}"
  priorities = [1, 2]
  cidr_ips = ["${var.vswitch_cidrs}", "${var.ssl_vpn_ip_pool}"]
  
}

# Create VPN Gateway #
######################

module "vpn-gateway" {
	source = "../../modules/vpn-gateway"
    vpc_id = "${module.vpc.vpc_id}"
    security_group_id = "${module.security-group.security_group_id}"
    ssl_vpn_ip_pool = "${var.ssl_vpn_ip_pool}"
    vpc_cidr = "${var.vpc_cidr}"
}

# Create ssh key for admin servers

resource "alicloud_key_pair" "key" {
    key_name = "ssh_key_admin_srv"
}

# Create Admin Workstation #
############################

resource "alicloud_instance" "mgmt-srv" {
  
  count = "1"
  security_groups = ["${module.security-group.security_group_id}"]
  
  vswitch_id = "${alicloud_vswitch.vswitch.*.id[count.index]}"

  instance_name = "${format("srv-%s-%02d", var.app_prefix, count.index + 1)}"
  instance_type = "${data.alicloud_instance_types.default.instance_types.0.id}"
  host_name = "${format("srv-%s-%02d", var.app_prefix, count.index + 1)}"
  image_id = "${var.image_id}"
  
  internet_max_bandwidth_out = 10
  key_name = "${alicloud_key_pair.key.key_name}"
}


  


