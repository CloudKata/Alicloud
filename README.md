# CloudBuilder

Terraform modules for provisoning infrastructure & environment on demand on public cloud platforms. 

## Cloud Provider Support 


1. [Alicloud](https://www.terraform.io/docs/providers/alicloud/index.html)

2. AWS (To be added)


## Directory Structure


	
	├── Cloud_EOD.jpg
	├── README.md
	├── environments
	│   └── prod
	│       ├── Setup.tf
	│       ├── admin_vpc
	│       │   ├── main.tf
	│       │   ├── output.tf
	│       │   └── variables.tf
	│       ├── secret.tf
	│       └── tenant_vpc
	│           ├── main.tf
	│           ├── output.tf
	│           └── variables.tf
	├── modules
	│   ├── app
	│   │   └── funding
	│   │       ├── main.tf
	│   │       ├── output.tf
	│   │       └── variables.tf
	│   ├── dns-public
	│   │   ├── main.tf
	│   │   └── variables.tf
	│   ├── ram
	│   │   ├── main.tf
	│   │   ├── output.tf
	│   │   └── variables.tf
	│   ├── slb
	│   │   ├── main.tf
	│   │   ├── output.tf
	│   │   └── variables.tf
	│   └── vpn-gateway
	│       ├── ssl-vpn.tf
	│       └── variables.tf
	├── provider.tf



## Sample Infrastructure Design


![Cloud_EOD.jpg](Cloud_EOD.jpg)
