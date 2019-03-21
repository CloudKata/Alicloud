variable "vpc_id" {}

variable "ssl_vpn_ip_pool" {}

variable "vpc_cidr" {}

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

