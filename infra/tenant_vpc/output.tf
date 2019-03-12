output "vpc_id" {
    description = "Id of the VPC just"
	value = "${module.vpc.vpc_id}"
}

output "vswitch_cidrs" {
	value = "${module.funding.vswitch_cidrs}"
}