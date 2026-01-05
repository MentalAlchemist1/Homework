
Cannot collaborate with team members if you have the state file on just your computer
- need a REMOTE STATE FILE
- need to host that state file for whatever provider we're using OFF of our computer and in a SECURED ENVIRONMENT (AWS SNS)

Must tell tf where to put the state file
- create S3 bucket
- modify tf code to place the state file in that bucket
- can't make S3 bucket FIRST because it's created at tf init
	- CAN be done if you want to MIGRATE the file
	- make mods
	- tf init
	- tf files directs state file into S3 bucket

Hashicorp
- providers
- aws
- s3 bucket

state file documentation -- 
https://developer.hashicorp.com/terraform/language/state

copy state.tf code
# state.tf
terraform {
  backend "s3" {
    bucket = "" 
    key    = ""
    region = ""
    profile= ""
  }
}

how to store state remotely
[Backend Type: s3 | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/backend/s3 "https://developer.hashicorp.com/terraform/language/backend/s3")

![[Screenshot 2025-11-25 at 9.46.02 PM.png]]


Need to make sure they have access to the state file...add to 0-auth file

terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }
}

- bucket name: shadow-titan-s3bucket
- key = whatever you like...the name of the object in the bucket. Change for each bucket or they will overwrite. Terraform calls this path the "key"
	- "class7/terraform/shadowtitan/S3BackendDemo"

Have at least ONE folder here though...
- "class7/terraform/shadowtitan/S3BackendDemo"


Region for bucket can be different from AWS Provider config below
- AWS Provider config...connects you to that stated AWS REGION = building infrastructure
- the bucket you created is created in another region, if you want = state file location


Needed an actual resource
- vpc

# VPC resource

This creates the virtual private cloud:
![[Screenshot 2025-11-26 at 10.30.58 PM.png]]

This creates the bucket:
![[Screenshot 2025-11-26 at 10.29.47 PM.png]]

bucket == the s3 bucket you created

key == the actual name of the tf state file. whatever you name this key will be the actual name in the S3 bucket. if you add folders, the folders will be represented in the S3 bucket once tf apply is run and creates infrastructure. the last portion of the key value (right next to the closing quotation mark) will be the name of the key. try to make that == terraform.tfstate for consistency.

region == optional, also does not need to match the region where you are building the infrastructure.

<font color="#ff0000">if error when doing another</font>..."Error: Backend configuration changed"
- if you change the path, this would happen because you already ran tf init so you have to update tf on what the new config is
	- terraform init -migrate-state

![[Pasted image 20251125223410.png]]

You don't HAVE to put a region in your bucket-build.
- I probably want to take that away so it will default us-west-2 (Oregon) - your AWS configure command
- your login region - us-west-2 - has no idea what's going on in another region...KNOW what region you have your state in.
- 

![[Screenshot 2025-11-26 at 10.29.47 PM.png]]

1:49:30...post-S3 setup

Bring all other working files over

Change files as necessary
- subnets cidr block of vpc
- region of aws provider configuration
- vpc id (must match the vpc file)
	- subnets
	- igw
	- nat
	- route
	- sg
	- sg-lb
- comment out the EC2 (edit/toggle line comment)

do a live check on your # of AZs in your AWS region - us-west-2.

launch template = change the image ID
- image_id = "ami-02b297871a94f4b42" # Amazon Linux 2 AMI in us-west-2

Now, launch everything like usual = terraform IvPAD

Go to EC2, LB and wait until it finishes

SUCCESS!!

![[Screenshot 2025-11-27 at 12.13.30 AM.png]]
![[Screenshot 2025-11-27 at 12.16.21 AM.png]]

![[Screenshot 2025-11-27 at 12.16.43 AM.png]]

![[Screenshot 2025-11-27 at 12.17.03 AM.png]]

Look at your ASG...going to SNS topic
- Simple Notification Service...a way for AWS to send you push notifications if something happens.

![[Screenshot 2025-11-27 at 12.22.47 AM.png]]

EC2 - us-west-2 ()
ASG
Create notification
Create a topic
	- ASG
	- Activity tab
	- Create notification

![[Pasted image 20251127004307.png]]

Get these 3 signifiers
![[Screenshot 2025-11-27 at 12.27.48 AM.png]]

Test a notification
- look at how many instances you have.

SNS topic for ASG scaling
- you must go into your email to the new SNS topic + subscription you've created.
- terminate an instance to receive the emails.

	![[Screenshot 2025-11-27 at 12.44.53 AM.png]]

Goals accomplished:
- get the remote state file placed in an S3 bucket
- get SNS running

On ANY website, you can right click it and click INSPECT to see HTML/backend.
- HTML
- CSS
- Client side JS = more dynamic