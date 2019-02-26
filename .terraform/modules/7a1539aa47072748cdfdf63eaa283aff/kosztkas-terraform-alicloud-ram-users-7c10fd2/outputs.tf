output "users" {
  description = "List of created users"
  value = "${alicloud_ram_user.users.*.id}"
}
