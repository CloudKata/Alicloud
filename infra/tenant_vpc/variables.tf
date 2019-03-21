variable "vpc_name" {
	default = "vpc_tenant1"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "availability_zones" {
	default = ["ap-southeast-5a", "ap-southeast-5b"]
}

variable "role_name" {}

#variable "zone_id" {}