# Add a new Domain.
resource "alicloud_dns" "dns" {
  name = "starmove.com"                      
  group_id = "85ab8713-4a30-4de4-9d20-155ff830f651" 
}

# Add a new Domain group.
resource "alicloud_dns_group" "group" {
  name = "testgroup"
}

resource "alicloud_dns_record" "record" {
  name = "domainname"
  host_record = "@"
  type = "A"
  value = "192.168.99.99"
}
