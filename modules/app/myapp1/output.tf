output "instance_names" {
  value = "${alicloud_instance.myapp1.*.instance_name}"
}


output "host_names" {
  value = "${alicloud_instance.myapp1.*.host_name}"
}

output "private_ips" {
  value = "${alicloud_instance.myapp1.*.private_ip}"
}

output "key_name" {
  value = "${alicloud_key_pair.key.key_name}"
}

output "role_name" {
  value = "${alicloud_instance.myapp1.*.role_name}"
}

output "slb_name" {
  value = "${module.slb_myapp1.slb_name}"
}