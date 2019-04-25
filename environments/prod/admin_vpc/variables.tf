# VPC Variables

variable "vpc_prefix" {
  default = "admin"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "vpc_azs" {
  default = ["ap-southeast-5a", "ap-southeast-5b"]
}

variable "vswitch_cidrs" {
  default = ["10.10.1.0/24"]
}

# Add tenant vpc CIDRS

variable "destination_cidrs" {
  default = []
}

# Add tenant vpc router instance ids

variable "nexthop_ids" {
  default = []
}

variable "app_prefix" {
  default = "admin"
}

variable "natgw_spec" {
  default = "Small"
}

#Security Group Variables

variable "sg_port_ranges" {
  default = ["80/80", "22/22", "443/443"]
}

# ECS Instance Variables

variable "image_id" {
  default = "m-k1aimr39v8k6onvoxmhz"
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

variable "ssl_vpn_ip_pool" {
  default = "192.168.100.0/24"
}

variable "cen_instance_id" {}

variable "pvtz_zone_id" {}
