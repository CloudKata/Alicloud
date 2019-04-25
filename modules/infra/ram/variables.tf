variable "account_alias" {
  description = "account alias for RAM"
  default     = "myaccount"
}

variable "usernames" {
  default = ["dev1", "dev2", "admin1"]
}

variable "display_names" {
  default = ["developer1", "developer2", "administrator1"]
}

variable "emailids" {
  default = ["dev1@example.com", "dev2@example.com", "admin1@example.com"]
}

variable "group_name" {
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

variable "password" {
  description = "default password for login"
  default     = "P@ssw0rd"
}

variable "policy_action" {
  default = [
#    "ecs:[ECS RAM Action]"
#    "ecs:AttachInstanceRamRole",
    "vpc:DescribeVpcs",
    "vpc:DescribeVSwitches",
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
