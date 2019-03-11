
module "vpc" {
   source = "alibaba/vpc/alicloud"
   version = "1.1.0"
   
   vpc_name = "${var.vpc_name}"
   vpc_description = "${var.vpc_name}"
   vpc_cidr = "${var.vpc_cidr}"

   #vswitch_name = "${var.vswitch_name}"
   #vswitch_description = "default"
   #vswitch_cidrs = "${var.vswitch_cidrs}"

   availability_zones = "${var.availability_zones}"

}

module "funding" {
	source = "../../roles/funding"
    
	vpc_id = "${module.vpc.vpc_id}"
   role_name = "instance-role"
}