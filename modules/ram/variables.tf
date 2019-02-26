variable "account_id" {
	default = "5104523510172198"
}
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
	default = "users"
}

variable "service_names" {
	default = ["ecs.aliyuncs.com", "apigateway.aliyuncs.com"]
}

variable "policy_name" {
	default = []
}

variable "policy_action" {
	default = [
                "ecs:*"
                "vpc:DescribeVpcs",
                "vpc:DescribeVSwitches"
            ]
}

variable "policy_resource" {
	default = "*"
}
variable "policy_effect" {
	default = "allow"
}

variable "role_name" {
	default = "TF-Role"
}
variable "service_names" {
	default = ["ecs.aliyuncs.com", "apigateway.aliyuncs.com"]
}