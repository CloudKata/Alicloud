#Create VPN Gateway

resource "alicloud_vpn_gateway" "vpn_gw" {
    name = "${var.vpn_gw_name}"
    vpc_id = "${var.vpc_id}"
    bandwidth = "10"
    enable_ssl = true
    enable_ipsec = false
    instance_charge_type = "PostPaid"
    description = "SSL Client VPN"
}

#Create SSL VPN Server
resource "alicloud_ssl_vpn_server" "client_vpn_srv" {
    name = "${var.ssl_vpn_name}"
    vpn_gateway_id = "${alicloud_vpn_gateway.vpn_gw.id}"
    client_ip_pool = "${var.ssl_vpn_ip_pool}"
    local_subnet = "${var.vpc_cidr}"
    protocol = "${var.ssl_vpn_protocols}"
    cipher = "${var.ssl_vpn_encryption}"
    compress = "false"
}

#Create SSL VPN Client Cert

resource "alicloud_ssl_vpn_client_cert" "client_vpn_cert" {
    ssl_vpn_server_id = "${alicloud_ssl_vpn_server.client_vpn_srv.id}"
    name = "ssl_client_vpn_cert"
}

