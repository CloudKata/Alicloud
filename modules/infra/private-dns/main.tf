resource "alicloud_pvtz_zone" "internal" {
    name = "${var.zone_name}"
}

resource "alicloud_pvtz_zone_attachment" "attachment" {
  zone_id = "${alicloud_pvtz_zone.internal.id}"
  vpc_ids = ["${var.vpc_id_list}"]
  count   = "${var.need_attachment ? 1 : 0}"
}