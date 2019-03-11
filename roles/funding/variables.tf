variable "vpc_id" {}

variable "app_prefix" {
	default = "funding"
}

variable "port_ranges" {
	default = ["80/80", "22/22", "443/443"]
}

variable "cpu_core_count" {
	default = 1
}
variable "memory_size" {
	default = 0.5
}
variable "instance_type_family" {
	default = "ecs.t5"
}
variable "vswitch_cidrs" {
	default = [
      "10.20.1.0/24",
      "10.20.2.0/24"
   ]
}
variable "role_name" {}


variable "image_id" {
	default = "m-k1aimr39v8k6onvoxmhz"
}




