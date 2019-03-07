variable "vpc_name" {
	default = "vpc_tenant1"
}
variable "vswitch_name" {
	default = "default_tenant1"
}
variable "vswitch_cidrs" {
	default = [
      "10.10.1.0/24",
      "10.10.2.0/24"
   ]
}

variable "vpc_az" {
	default = ["ap-southeast-5a", "ap-southeast-5b"]
}

variable "destination_cidrs" {
	default = ["172.17.1.0/24", "172.17.2.0/24"]
}
variable "sg_name" {
	default = "mgmt_sg"
}

variable "slb_instance_ids" {
	default = []
}