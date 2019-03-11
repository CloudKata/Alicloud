# RAM Users and Group

data "alicloud_account" "current"{
}

output "current_account_id" {
  value = "${data.alicloud_account.current.id}"
}

module "ram-users" {
  source  = "kosztkas/ram-users/alicloud"
  version = "1.0.1"
  usernames = "${var.alicloud_ram_users}"
  dispnames = "${var.ram_display_names}"
  emails = "${var.ram_user_emailid}"
  group_name = "${var.ram_group_name}"
  alicloud_access_key = "${var.alicloud_access_key}"
  alicloud_secret_key = "${var.alicloud_secret_key}"
  
}

resource "alicloud_ram_group_policy_attachment" "attach" {
  policy_name = "ReadOnlyAccess"
  policy_type = "System"
  group_name = "${var.ram_group_name}"
  depends_on = ["module.ram-users"]
}


#Create Service Role and Attach Custom Policy

resource "alicloud_ram_role" "role" {
  name = "${var.role_name}"  
  ram_users = ["acs:ram::${data.alicloud_account.current.id}:root"]
  services = "${var.services}"
  description = "this is a service role."
}

resource "alicloud_ram_policy" "role_policy" {
  name = "${var.policy_name}"
  statement = [{
            action = "${var.policy_action}"
            resource = "${var.policy_resource}"
            effect = "${var.policy_effect}"
        }]

  description = "Instance policy for infrastructure provisioning"
}


resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = "${var.policy_name}"
  policy_type = "${var.policy_type}"
  role_name = "${var.role_name}"
  depends_on = ["alicloud_ram_role.role", "alicloud_ram_policy.role_policy"]
}

