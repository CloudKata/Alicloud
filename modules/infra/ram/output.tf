output "role_name" {
  value = "${alicloud_ram_role.role.name}"
}

output "user_id" {
  value = "${alicloud_ram_user.user.*.id}"
}
