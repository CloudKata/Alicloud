# CloudBuilder

Terraform modules for provisoning infrastructure & environment on demand on public cloud platforms. 

## Cloud Provider Support 


1. [Alicloud](https://www.terraform.io/docs/providers/alicloud/index.html)

2. AWS (To be added)


## Directory Structure

	├── environments
	│   └── prod
	│       ├── admin_vpc
	│       ├── main.tf
	│       ├── tenant_vpc
	|
	├── modules
	│   ├── app
	│   │   └── funding
	│   └── infra
	│       ├── dns-public
	│       ├── private-dns
	│       ├── ram
	│       ├── slb
	│       └── vpn-gateway


## Environment Setup

To setup complete production infrastructure 

	$ cd environments/prod
	$ terraform init
	$ terraform plan
	$ terraform apply

## Issues
 
Terraform apply might fail at the first run due to vpcs not being available to private zones. Inorder to fix it rerun the setup.


## Sample Infrastructure Design


![Cloud_EOD.jpg](Cloud_EOD.jpg)
