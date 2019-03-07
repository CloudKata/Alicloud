variable "alicloud_access_key" {}
variable "alicloud_secret_key" {}

variable "alicloud_ram_users" {
	default = ["dev1", "dev2", "admin1"]
}

variable "ram_display_names" {
	default = ["developer1", "developer2", "administrator1"]
}

variable "ram_user_emailid" {
	default = ["dev1@example.com", "dev2@example.com", "admin1@example.com"]
}

variable "ram_group_name" {
	default = "console-users"
}

variable "service_names" {
	default = ["ecs.aliyuncs.com", "apigateway.aliyuncs.com"]
}

variable "role_name" {
	default = "instance-role"
}

variable "policy_name" {
	default = "instance-role-policy"
}

variable "policy_type" {
	default = "Custom"
}

variable "policy_action" {
	default = [
                "ecs:*",
                "vpc:DescribeVpcs",
                "vpc:DescribeVSwitches"
            ]
}

variable "policy_resource" {
	default = ["*"]
}
variable "policy_effect" {
	default = "Allow"
}

variable "services" {
	default = ["ecs.aliyuncs.com", "apigateway.aliyuncs.com"]
}