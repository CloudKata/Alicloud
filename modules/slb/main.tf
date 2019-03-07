module "slb-int" {
     source = "alibaba/slb/alicloud"
     name = "${var.slb_name}"
     internal = true
     bandwidth = 5
     spec = "slb.s1.small"
     instances = "${var.instances}"
  }

resource "alicloud_slb_acl" "acl" {
  name = "${module.slb-int.this_slb_name}-acl"
  ip_version = "ipv4"
  entry_list = [
    {
      entry="0.0.0.0/0"
      comment="first"
    }
  ]
}

resource "alicloud_slb_listener" "http" {
  load_balancer_id = "${module.slb-int.this_slb_id}"
  backend_port = 80
  frontend_port = 80
  bandwidth = 10
  protocol = "http"
  sticky_session = "on"
  sticky_session_type = "insert"
  cookie = "slbHttplistenercookie"
  cookie_timeout = 86400
  acl_status                = "off"
  acl_type                  = "white"
  acl_id                    = "${alicloud_slb_acl.acl.id}"
}

resource "alicloud_slb_listener" "https" {
  load_balancer_id = "${module.slb-int.this_slb_id}"
  backend_port = 443
  frontend_port = 443
  bandwidth = 10
  protocol = "https"
  sticky_session = "on"
  sticky_session_type = "insert"
  cookie = "slbHttpslistenercookie"
  cookie_timeout = 86400
  acl_status                = "off"
  acl_type                  = "white"
  acl_id                    = "${alicloud_slb_acl.acl.id}"
}

resource "alicloud_slb_listener" "tcp" {
  load_balancer_id = "${module.slb-int.this_slb_id}"
  backend_port = "22"
  frontend_port = "22"
  protocol = "tcp"
  bandwidth = "10"
  health_check_type = "tcp"
  acl_status                = "on"
  acl_type                  = "black"
  acl_id                    = "${alicloud_slb_acl.acl.id}"
  established_timeout       = 600
}