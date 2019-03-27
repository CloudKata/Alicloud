 module "dns" {
     source = "terraform-alicloud-modules/dns/alicloud"

     domain_name = "${var.domain_name}"
     group_name = "${var.domain_name}"
     record_list = [
         {
             name = "www"
             type = "A"
             ttl  = 86400
             value = "223.5.5.5"
             priority = 1
         },
         {
             name = "www"
             type = "A"
             ttl  = 86400
             value = "223.5.5.5"
             priority = 1
         }
     ]
 }

