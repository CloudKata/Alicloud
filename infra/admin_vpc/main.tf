
# Create Management VPC
# ======================

module "vpc" {
   source = "alibaba/vpc/alicloud"
   version = "1.1.0"
   
   vpc_name = "${var.vpc_name}"
   vpc_description = "${var.vpc_name}"

   vswitch_name = "vswitch-${var.vpc_name}"
   vswitch_description = "Default vswitch for vpc"
   vswitch_cidrs = "${var.vpc_vswitch_cidrs}"

   availability_zones = "${var.vpc_az}"

# destination_cidrs = "${var.destination_cidrs}"

}

#Create Users, Groups, Roles, Policy

module "ram" {
	source = "../../modules/ram"
  alicloud_access_key = "${var.alicloud_access_key}"
  alicloud_secret_key = "${var.alicloud_secret_key}"
}

# Create Management Security Group
# ================================

module "security-group" {
  source = "alibaba/security-group/alicloud"

  vpc_id = "${module.vpc.vpc_id}"
  group_name = "sg-${var.vpc_name}"
  rule_directions = ["ingress"]
  ip_protocols = ["tcp", "tcp", "tcp"]
  policies = ["accept", "accept"]
  port_ranges = "${var.sg_port_ranges}"
  priorities = [1, 2]
  cidr_ips = "${var.vpc_vswitch_cidrs}"
  
}

# Create VPN Gateway
# ==================

module "vpn-gateway" {
	source = "../../modules/vpn-gateway"
    vpc_id = "${module.vpc.vpc_id}"
    security_group_id = "${module.security-group.security_group_id}"
}

# Create ssh key for admin servers

resource "alicloud_key_pair" "key" {
    key_name = "ssh_key_admin_srv"
}

# Create Admin Workstation
# ========================

module "ecs-instance" {
  source = "alibaba/ecs-instance/alicloud"
  
  group_ids = "${module.security-group.security_group_id}"
  vswitch_id = "${module.vpc.vswitch_ids}"

  image_id = "${var.image_id}"
  number_of_instances = "1"

  instance_name = "mgmt-workstation"

  host_name = "tf-admin"

  disk_name = "{instance_name}-data"
  disk_category = "${var.disk_category}"
  
  disk_size = "${var.disk_size}"
  number_of_disks = "${var.disk_count}"
  
  key_name = "${alicloud_key_pair.key.key_name}"

}


  


