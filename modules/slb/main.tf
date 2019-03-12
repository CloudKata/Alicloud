module "slb" {
     source = "alibaba/slb/alicloud"
     internal = true
     bandwidth = 5
     spec = "slb.s1.small"
     instances = "${var.instances}"
     name = "${var.name}"
  }

resource "alicloud_slb_acl" "acl" {
  name = "${module.slb.this_slb_name}-acl"
  ip_version = "ipv4"
  entry_list = [
    {
      entry="10.0.0.0/8"
      comment="first"
    },
    { 
      entry="192.168.100.0/24"
      comment="second"

    }
      
  ]
}

resource "alicloud_slb_listener" "http" {
  load_balancer_id = "${module.slb.this_slb_id}"
  backend_port = 80
  frontend_port = 80
  bandwidth = 10
  protocol = "http"
  sticky_session = "on"
  sticky_session_type = "insert"
  cookie = "slbHttplistenercookie"
  cookie_timeout = 86400
  health_check_type = "http"
  health_check_connect_port = "80"
  acl_status                = "off"
  acl_type                  = "white"
  acl_id                    = "${alicloud_slb_acl.acl.id}"
}

resource "alicloud_slb_listener" "tcp" {
  load_balancer_id = "${module.slb.this_slb_id}"
  backend_port = "22"
  frontend_port = "22"
  protocol = "tcp"
  bandwidth = "10"
  health_check_type = "tcp"
  health_check_connect_port = "22"
  acl_status                = "on"
  acl_type                  = "black"
  acl_id                    = "${alicloud_slb_acl.acl.id}"
  established_timeout       = 600
}