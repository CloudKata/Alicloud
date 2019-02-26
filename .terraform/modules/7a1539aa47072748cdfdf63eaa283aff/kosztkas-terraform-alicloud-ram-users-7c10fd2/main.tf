provider "alicloud" {
    access_key = "${var.alicloud_access_key}"
    secret_key = "${var.alicloud_secret_key}"
}

resource "alicloud_ram_user" "users" {
  count = "${length(var.usernames)}"
  name = "${element(var.usernames, count.index)}"
  display_name = "${element(var.dispnames, count.index)}"
  email = "${element(var.emails, count.index)}"
}

resource "alicloud_ram_login_profile" "profile" {
  user_name = "${element(var.usernames, count.index)}"
  password = "${var.password}"
  password_reset_required = "true"
  depends_on = ["alicloud_ram_user.users"]
}

resource "alicloud_ram_group" "group" {
  name = "${var.group_name}"
  comments = "This is a group created by Terraform"
}

resource "alicloud_ram_group_membership" "membership" {
  group_name = "${var.group_name}"
  user_names = "${var.usernames}"
  depends_on = ["alicloud_ram_user.users"]
}
