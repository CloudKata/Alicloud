# VPC Variables

variable "vpc_name" {
	default = "vpc-admin"
}
variable "vpc_cidr" {
	default = "10.10.0.0/16"
}

variable "vpc_az" {
	default = ["ap-southeast-5a", "ap-southeast-5b"]
}

variable "vpc_vswitch_cidrs" {
	default = ["10.10.1.0/24", "10.10.2.0/24"]
}

# Add tenant vpc CIDRS

variable "destination_cidrs" {
	default = []
}

# Add tenant vpc router instance ids

variable "nexthop_ids" {
	default = []
}


#Security Group Variables

variable "sg_port_ranges" {
	default = ["80/80", "22/22", "443/443"]
}

# ECS Instance Variables

variable "instance_count" {
	default = "1"
}

variable "disk_size" {
	default = "50"
}

variable "disk_count" {
	default = "1"
}

variable "disk_category" {
	default = "cloud_ssd"
}
variable "image_id" {
	default = "m-k1aimr39v8k6onvoxmhz"
}


