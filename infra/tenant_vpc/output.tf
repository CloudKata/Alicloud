output "vpc_id" {
    description = "Id of the VPC just"
	value = "${alicloud_vpc.vpc.id}"
}