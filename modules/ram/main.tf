# RAM Users and Group
module "ram-users" {
  source  = "kosztkas/ram-users/alicloud"
  version = "1.0.1"

  usernames = "${var.alicloud_ram_users}"
  dispnames = "${var.ram_display_names}"
  emails = "${var.ram_user_emailid}"
  group_name = "${var.ram_group_name}"
  alicloud_access_key = "${var.access_key}"
  alicloud_secret_key = "${var.secret_key}"
}



# Add Group Policy
resource "alicloud_ram_group_policy_attachment" "attach" {
  policy_name = "ReadOnlyAccess"
  policy_type = "System"
  group_name = "${var.ram_group_name}"
}




resource "alicloud_ram_policy" "role_policy" {
  name = "${var.policy_name}"
  statement = [
        {
            "action": "${var.policy_action}",
            "resource": "${var.policy_resource}",
            "effect": "${var.policy_effect}"
        }
      
  description = "Instance policy for infrastructure provisioning"
}

resource "alicloud_ram_role" "role" {
  name = "instance-role"  
  ram_users = ["acs:ram::${var.account_id}:root"]
  services = "${var.service_names}"
  description = "this is a service role."
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = "${var.policy_name}"
  policy_type = "${var.policy_type}"
  role_name = "${alicloud_ram_role.role.name}"
}

