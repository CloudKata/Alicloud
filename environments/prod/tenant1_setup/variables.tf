variable "tenant_prefix" {
  default = "tenant1"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "availability_zones" {
  default = ["ap-southeast-5a", "ap-southeast-5b"]
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

variable "role_name" {}

variable "pvtz_zone_id" {}

variable "app_prefix" {
  default = "funding"
}

variable "natgw_spec" {
  default = "Small"
}
