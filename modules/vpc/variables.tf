variable "access_key" {
	default = "LTAIr7UC052hN3XW"
}
variable "secret_key" {
	default = "3APPL8YOpbZkDUKAUIh8P4UopuWf2J"
}
variable "region" {
  default = "ap-southeast-5"
}
variable "vpc_name" {
	default = "test1"
}
variable "vswitch_name" {
	default = "default1"
}
variable "destination_cidrs" {
	default = ["172.17.1.0/24", "172.17.2.0/24"]
}
variable "sg_name" {
	default = "mgmt_sg"
}
variable "vpc_cidrs" {
	default = ["172.16.1.0/24"]
}
variable "vpc_az" {
	default = ["ap-southeast-5a", "ap-southeast-5b"]
}
variable "sg_ingress_ports" {
	default = ["80/80", "22/22", "443/443"]
}
