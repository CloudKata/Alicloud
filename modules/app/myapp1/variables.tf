variable "vpc_id" {}

variable "pvtz_zone_id" {}

variable "app_prefix" {
  default = "funding"
}

variable "port_ranges_http" {
  default = ["80/80"]
}

variable "port_ranges_ssh" {
  default = ["22/22"]
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

variable "role_name" {
  default = "instance-role"
}

variable "image_id" {
  default = "m-k1aimr39v8k6onvoxmhz"
}

variable "snat_table_id" {}
variable "snat_ip" {}

variable "vswitch_cidrs" {
  default = [
    "10.20.1.0/24",
    "10.20.2.0/24",
  ]
}

variable "ingress_ips" {
  default = [
    "10.10.0.0/16",
    "192.168.100.0/24",
    "10.20.1.0/24",
    "10.20.2.0/24",
  ]
}

variable "priorities" {
  default = ["1"]
}

variable "rule_directions" {
  default = ["ingress"]
}

variable "ip_protocols" {
  default = ["tcp"]
}

variable "policies" {
  default = ["accept"]
}

variable "password" {
  description = "default password"
  default     = "P@ssw0rd"
}
