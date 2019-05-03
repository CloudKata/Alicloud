output "role_name" {
  value = "${alicloud_ram_role.role.name}"
}

output "user_names" {
  value = "${alicloud_ram_user.user.*.name}"
}
