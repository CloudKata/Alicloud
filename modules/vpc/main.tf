# Create Management VPC

module "vpc" {
   source = "alibaba/vpc/alicloud"
   version = "1.1.0"
   
   vpc_name = "${var.vpc_name}"
   vpc_description = "default"

   vswitch_name = "${var.vswitch_name}"
   vswitch_description = "default"
   vswitch_cidrs = "${var.vpc_cidrs}"

   availability_zones = "${var.vpc_az}"

# destination_cidrs = "${var.destination_cidrs}"

}

# Create Management Security Group

module "security-group" {
  source = "alibaba/security-group/alicloud"

  vpc_id = "${module.vpc.vpc_id}"
  group_name = "${var.sg_name}"
  rule_directions = ["ingress"]
  ip_protocols = ["tcp", "tcp", "tcp"]
  policies = ["accept", "accept"]
  port_ranges = "${var.sg_ingress_ports}"
  priorities = [1, 2]
  cidr_ips = "${var.vpc_cidrs}"
  
}

#Create VPN Gateway

# Create ECS Instance for Mgmt Workstation

#resource "alicloud_instance" "instance" {
#
#  security_groups = ["${module.security-group.security_group_id}"]
#  vswitch_id = "${module.vpc.vswitch_ids}"
#
#  instance_type = "ecs.t5-lc2m1.nano"
#  system_disk_category = "cloud_ssd"
#
#  image_id = "m-k1aimr39v8k6onvoxmhz"
#  instance_name = "mgmt_workstation"
#  host_name = "tf-admin"
#
#}



