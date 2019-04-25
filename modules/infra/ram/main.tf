###################################################################################################
# Collect current cloud account id from data sources. Needed by ram role resource to add user arn #
###################################################################################################

data "alicloud_account" "current" {}

output "current_account_id" {
  value = "${data.alicloud_account.current.id}"
}

resource "alicloud_ram_account_alias" "alias" {
  account_alias = "${var.account_alias}"
}

##############################
# Create RAM Users and Group #
##############################

resource "alicloud_ram_user" "user" {
  count        = "${length(var.usernames)}"
  name         = "${element(var.usernames, count.index)}"
  display_name = "${element(var.display_names, count.index)}"
  email        = "${element(var.emailids, count.index)}"
  force        = true
}

resource "alicloud_ram_login_profile" "profile" {
  count                   = "${length(var.usernames)}"
  user_name               = "${element(var.usernames, count.index)}"
  password                = "${var.password}"
  mfa_bind_required       = "true"
  password_reset_required = "true"
  depends_on              = ["alicloud_ram_user.user"]
}

resource "alicloud_ram_group" "group" {
  name       = "${var.group_name}"
  depends_on = ["alicloud_ram_user.user"]
}

resource "alicloud_ram_group_membership" "membership" {
  group_name = "${alicloud_ram_group.group.name}"
  user_names = "${var.usernames}"
  depends_on = ["alicloud_ram_user.user", "alicloud_ram_group.group"]
}

####################################################
# Attach permissions for resources in group policy #
####################################################

resource "alicloud_ram_group_policy_attachment" "attach" {
  policy_name = "ReadOnlyAccess"
  policy_type = "System"
  group_name  = "${alicloud_ram_group.group.name}"
  depends_on  = ["alicloud_ram_user.user"]
}

#################################################################################################################################
# Role Policy for cloud resource access. This one create an ecs instance role. To add other resources update var policy_action ##
#################################################################################################################################

resource "alicloud_ram_role" "role" {
  name        = "${var.role_name}"
  ram_users   = ["acs:ram::${data.alicloud_account.current.id}:root"]
  services    = "${var.services}"
  description = "this is a service role."
}

resource "alicloud_ram_policy" "role_policy" {
  name = "${var.policy_name}"

  statement = [{
    action   = "${var.policy_action}"
    resource = "${var.policy_resource}"
    effect   = "${var.policy_effect}"
  }]

  description = "Instance policy for infrastructure provisioning"
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = "${var.policy_name}"
  policy_type = "${var.policy_type}"
  role_name   = "${var.role_name}"
  depends_on  = ["alicloud_ram_role.role", "alicloud_ram_policy.role_policy"]
}
