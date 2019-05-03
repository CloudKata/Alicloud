# CloudBuilder

Terraform modules for provisoning infrastructure & environment on demand on public cloud platforms. 

## Description

The setup creates 2 vpcs (admin and tenant).

It consists of custom modules to create infrastructure resources and application services as below:

		├── app
		│   └── funding => Creates appservers with vswitch, security group , slb and dns entry   
		│       
		└── infra
		    ├── dns-private-zone => Creates dns private zone and attaches vpcs
		    │   
		    │   
		    ├── dns-public => Creates public dns 
		    │   
		    │   
		    ├── ram => Creates ram users, groups , roles & pilicies
		    │   
		    │  
		    ├── slb => Creates service load balancers and rules
		    │      
		    ├── vpc_association  => Associates vpcs to Cen instance for vpc-vpc peering and attaches vpcs to private dns zones
		    │     
		    └── vpn-gateway => Creates VPN gateway along with ssl server and ssl client certs.      
           
And modules to bootstrap environments. Current setup will create a production environment with 1 vpc for hosting centralized shared admin services and 1 vpc for hosting tenant specific applications and services. The services hosted in the admin vpc will be governing the tenant vpcs. The layout goes as below: 

		├── environments => Modules for provisioning infrastructure for centralised services and tenant environments. 
			└── prod
			    ├── admin_setup => Module to create admin vpc with centralised shared services, VPN gateway and NAT gateway
			    │   
			    ├── tenant1_setup => Module to create tenant vpc with app servers
			    |  
			    ├── run.tf => Bootstraps the infrastructure defined

## Bootstrap Environment:

**Variable**

	need_attachment = true | false


This is needed to add wait time for the private dns zones and cen instances to be ready before the vpcs are associated with them.

**Setup**

		$ terraform init -var="need_attachment=true

		$ terraform plan -var="need_attachment=true

		$ terraform apply -var="need_attachment=false"  #Without vpc attachment

		$ terraform apply -var="need_attachment=true"

## Known Issues
 
Private dns zones take some time to discover the vpcs before binding them. It does not discover them immediately though the vpcs might be available. That is why terraform apply is needed to be executed twice with the need_attachment flag. 

## How to login to instances

This setup will create ssh pem files within the current working directory that can be used to ssh into the instances created.



## Sample Infrastructure Design


![Cloud_EOD.jpg](Cloud_EOD.jpg)
