variable "vpc_id" {}

variable "vswitch_id" {}  

variable "group_name" {
	default = "funding"
}

variable "port_ranges" {
	default = ["80/80", "22/22", "443/443"]
}

variable "instance_count" {
	default = "2"
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




