####################################################
# Collect Instance Types available in the vpc zone #
####################################################

data "alicloud_instance_types" "default" {
  cpu_core_count       = "${var.cpu_core_count}"
  memory_size          = "${var.memory_size}"
  instance_type_family = "${var.instance_type_family}"
}

#####################
# Collect zone data #
#####################

data "alicloud_zones" main {
  available_resource_creation = "VSwitch"
  multi                       = true
  network_type                = "Vpc"
}

#####################################
# Save zone names in local variable #
#####################################

locals {
  vpc_azs = "${data.alicloud_zones.main.zones.0.id}, ${data.alicloud_zones.main.zones.1.id}"
}

##########################################
# Create Security Group for the instance #
##########################################

resource "alicloud_security_group" "default" {
  name   = "${var.app_prefix}"
  vpc_id = "${var.vpc_id}"
}

resource "alicloud_security_group_rule" "allow_http" {
  count             = "${length(var.ingress_ips)}"
  type              = "${element(var.rule_directions, count.index)}"
  ip_protocol       = "${element(var.ip_protocols, count.index)}"
  nic_type          = "intranet"
  policy            = "${element(var.policies, count.index)}"
  port_range        = "${element(var.port_ranges_http, count.index)}"
  priority          = "${element(var.priorities, count.index)}"
  security_group_id = "${alicloud_security_group.default.id}"
  cidr_ip           = "${element(var.ingress_ips, count.index)}"
}

resource "alicloud_security_group_rule" "allow_ssh" {
  count             = "${length(var.ingress_ips)}"
  type              = "${element(var.rule_directions, count.index)}"
  ip_protocol       = "${element(var.ip_protocols, count.index)}"
  nic_type          = "intranet"
  policy            = "${element(var.policies, count.index)}"
  port_range        = "${element(var.port_ranges_ssh, count.index)}"
  priority          = "${element(var.priorities, count.index)}"
  security_group_id = "${alicloud_security_group.default.id}"
  cidr_ip           = "${element(var.ingress_ips, count.index)}"
}

################################
# Create instance ssh key pair #
################################

resource "alicloud_key_pair" "key" {
  key_name = "ssh_key_${var.app_prefix}"
  key_file = "${var.app_prefix}_ssh_key.pem"
}

##################
# Create vswitch #
##################

resource "alicloud_vswitch" "vswitch" {
  count             = "${length(var.vswitch_cidrs)}"
  vpc_id            = "${var.vpc_id}"
  name              = "${format("vsw-%s-%02d", var.app_prefix, count.index + 1)}"
  cidr_block        = "${var.vswitch_cidrs[count.index]}"
  availability_zone = "${element(split(", ", local.vpc_azs), count.index)}"
}

#########################
# Create instance batch #
#########################

resource "alicloud_instance" "funding" {
  count           = "${length(data.alicloud_zones.main.zones)}"
  security_groups = ["${alicloud_security_group.default.id}"]

  vswitch_id = "${alicloud_vswitch.vswitch.*.id[count.index]}"

  instance_name = "${format("srv-%s-%02d", var.app_prefix, count.index + 1)}"
  instance_type = "${data.alicloud_instance_types.default.instance_types.0.id}"
  host_name     = "${format("srv-%s-%02d", var.app_prefix, count.index + 1)}"
  image_id      = "${var.image_id}"

  key_name  = "${alicloud_key_pair.key.key_name}"
  role_name = "${var.role_name}"
}

## Add SNAT Entry ##

resource "alicloud_snat_entry" "snat" {
  count             = "${length(data.alicloud_zones.main.zones)}"
  snat_table_id     = "${var.snat_table_id}"
  source_vswitch_id = "${alicloud_vswitch.vswitch.*.id[count.index]}"
  snat_ip           = "${var.snat_ip}"
}

########################################################
# Create and Attach instances to service load balancer #
########################################################

module "slb_funding" {
  source       = "../../../modules/infra/slb"
  instance_ids = ["${alicloud_instance.funding.*.id}"]
  vswitch_id   = "${alicloud_vswitch.vswitch.0.id}"
  name         = "slb-${var.app_prefix}"
}
