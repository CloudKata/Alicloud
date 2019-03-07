variable "vpc_id" {}

variable "security_group_id" {}

variable "vpn_gw_name" {
	default = "ssl_vpn_gw"
}

variable "ssl_vpn_name" {
	default = "ssl_vpn_srv"
}

variable "ssl_vpn_protocols" {
	default = "TCP"
}

variable "ssl_vpn_ports" {
	default = ["22", "80", "443"]
}

variable "ssl_vpn_encryption" {
	default = "AES-128-CBC"
}

variable "ssl_vpn_ip_pool" {
	default = "192.168.100.0/24"
}
variable "ssl_vpn_subnet" {
	default = "172.16.1.0/24"
}