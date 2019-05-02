# CloudBuilder

Terraform modules for provisoning infrastructure & environment on demand on public cloud platforms. 

## Environment Setup

This setup will create 1 admin and 1 tenant vpcs as per the arhitecture diagram given below. Entire code is divided into two groups :

1. **modules:** 

This includes modules specific to invidual infrastructure components and application modules.

		├── modules
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
           


2. **environments:**  

Theis has modules to bootstrap the complete production environment.

		├── environments => Modules for provisioning infrastructure for centralised services and tenant environments. 
			└── prod
			    ├── admin_setup => Module to create admin vpc with centralised shared services, VPN gateway and NAT gateway
			    │   
			    ├── tenant1_setup => Module to create tenant vpc with app servers
			    |  
			    ├── run.tf => Bootstraps the infrastructure defined

3. **Bootstrap Environments from Scratch:**

**_Variable Definition_**

need_attachment = true | false
need_to_wait = true | false

These variables are need to be defined to add wait time for the private dns zones and cen instances to be ready before the vpcs are associated with them.

**_Run Setup_**

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
