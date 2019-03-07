
module "security-group" {
  source = "alibaba/security-group/alicloud"

  vpc_id = "${var.vpc_id}"
  group_name = "${var.group_name}"

  rule_directions = ["ingress"]
  ip_protocols = ["tcp", "tcp", "tcp"]
  policies = ["accept", "accept"]
  priorities = [1, 2]
  port_ranges = "${var.port_ranges}"
}

resource "alicloud_key_pair" "key" {
  key_name = "ssh_key_${var.group_name}"
}

module "ecs-instance" {
  source = "alibaba/ecs-instance/alicloud"

  vswitch_id = "${var.vswitch_id}"
  group_ids = "${module.security-group.security_group_id}"
  image_id = "${var.image_id}"

  number_of_instances = "${var.instance_count}"
  instance_name = "${var.group_name}-srv"
  
  host_name = "$${instance_name}-srv"

  disk_name = "$${instance_name}-data"
  disk_category = "${var.disk_category}"
  
  disk_size = "${var.disk_size}"
  number_of_disks = "${var.disk_count}"
  
  key_name = "${alicloud_key_pair.key.key_name}"
}

module "slb-int" {
     source = "alibaba/slb/alicloud"

     vswitch_id = "${var.vswitch_id}"

     name = "slb-int-${var.group_name}"
     
     internal = true
     bandwidth = 5
     spec = "slb.s1.small"

     instances = "${module.ecs-instance.instance_ids}"

  }