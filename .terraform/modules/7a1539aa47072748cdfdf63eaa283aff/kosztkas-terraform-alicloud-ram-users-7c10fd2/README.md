Alicloud RAM User Creation Terraform Module
===

Terraform module which adds list of users to a group with console logon and group membership. 
It assumes that you have RAM enabled already.

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf:

```
module "ram-users" {
  source  = "kosztkas/ram-users/alicloud"
  version = "1.0.0"
}
```

2. Setting values for the following variables in the variables file or through the environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - the lists of usernames, email addresses and display names
    - the default password setup for the users
    - the ram group name
    
Authors
-------
Created and maintained by Sandor Kosztka (@kosztkas)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/alibaba/terraform-provider)
* [Terraform-Provider-Alicloud Release](https://github.com/alibaba/terraform-provider/releases)
* [Terraform-Provider-Alicloud Latest Docs](http://47.95.33.19:4567/docs/providers/alicloud/)
