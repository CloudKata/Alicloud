variable "vpc_name" {
	default = "vpc_tenant1"
}

variable "vpc_cidr" {
	default = "10.20.0.0/16"
}

variable "availability_zones" {
	default = ["ap-southeast-5a", "ap-southeast-5b"]
}

variable "destination_cidrs" {
	default = ["172.17.1.0/24", "172.17.2.0/24"]
}
