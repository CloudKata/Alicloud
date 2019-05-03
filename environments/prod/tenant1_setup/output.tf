output "vpc_id" {
    description = "Id of the VPC just"
	value = "${alicloud_vpc.vpc.id}"
}

output "myapp1_instance_names" {
  
  value = "${module.myapp1.instance_names}"
}

output "myapp1_host_names" {
  value = "${module.myapp1.host_names}"
}

output "myapp1_private_ips" {
  value = "${module.myapp1.private_ips}"
}

output "myapp1_key_name" {
  value = "${module.myapp1.key_name}"
}

output "myapp1_role_name" {
  value = "${module.myapp1.role_name}"
}

output "myapp1_slb_name" {
  value = "${module.myapp1.slb_name}"
}