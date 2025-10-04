#budget 
#Aaron
#CIDR

Use Root User to login if you haven't given your IAM user permissions for Budget.

Billing and Cost Management  > Budget > Create Budget
- the budget gives you a heads up on how you're being billed.

[[EC2]]


EC2 Instance is interchangeable with the terms "virtual machine" (VM) and "Server"

Security Group
- Name
- Description
- VPC
	- each REGION gets a default VPC (172.31.0.0)
	- Ohio (172.31.0.0) has a different VPC than NoVA (10.231.0.0.)
	- 172.31.0.0
- Inbound Rules
	- for people OUTSIDE the VPC...they're trying to come in
	- "Ingress" traffic
	- Click Type (HTTP) > Source (Anywhere IPv4)
		- means it open to everyone/anywhere to come into the EC2
		- not random access though...a person would still need a "private" key
		- defaults to Protocol TCP and Port Range 80
		- Description = whatever
	- Click Type (SSH) > Source
		- stands for "secure shell"
		- its a secure way to remotely connect to your EC2 instance defaults to Protocol TCP and Port Range 80
		- allows secure management of remote servers, transfer files and execute command over unsecured networks like the internet.
		- uses public key cryography for secure authentication and encryption
- Outbound Rules
	- "Egress" traffic
	- DON'T TOUCH
- Tags = extra information that helps us manage/search for information about resources 
	- optional
	- Key = environment
- Click Create Security Group
	- Review the details just to make sure everything is what you input

Now, go to Instances
- open Theo's github so you can get the User Data script. https://github.com/MookieWAF/bmc4/blob/main/ec2scrpit
- Click Launch Instance
- Name Instance
- Application and OS Images (Amazon Machine Image)  = no change
- Instance Type
	- t3.micro = no change
- Key Pair
	- we use EC2 Instance Connect through AWS in order to connect
	- you don't need a key pair when using Connect, although it does use SSH
	- you can use a key pair to download a private key, which is like a password you can use to run SSH through your own CLI on your laptop.
	- Create new key pair
		- name it
		- Key pair type = RSA
		- Private key file format = .pem
		- click Create key pair
			- usually goes to Download folder
			- keep track of it...you can reuse these...don't delete them.
- Network Settings
	- do NOT click on Edit
	- Network = chooses the VPC
	- Subnet = No preference
	- Auto-assign public IP = Enable (definitely need)
	- Security Group = choose the one you created in previous step![[Screenshot 2025-10-03 at 11.11.26 AM.png]]
		- notice the SG and VPC numbers
		- you don't get charged for security groups
		- btw, never use Launch Wizard because it makes you look like an amateur and it also creates a bunch of security groups.
- Configure storage
	- collapse it
- Advanced Details
	- go to User data at bottom
	- copy Theo's script - https://github.com/MookieWAF/bmc4/blob/main/ec2scrpit
		- this script 
			- downloads and installs a web server on our EC2 instance
			- collects some "metadata" about the instance
			- writes some html code for the EC2 instance
			- replaces some metadata
		- Aaron goes through what each line here does in a class the week of 7-13 September
	- top will start with #!/bin/bash
	- go to bottom to make sure it all pasted
		- Clean up the temp files
		- rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
	- do NOT check "User data has already been base64 encoded"
- Review Summary for understanding of what you did

Click Launch Instance
Click on the hyperlink in green
- give it a minute for status checks to run
Copy the Public DNS
Type http:// before pasting the Public DNS url

Now, connect to the Instance
- click Connect from the Instance page
- EC2 Instance Connect tab > Connect using a Public IP
- Click Connect
- Congrats...you've connected to your server securely via SSH
- 
Send a command to your EC2 instance
- type ping 8.8.8.8 = Google (just sends some packets of data to an address/Google)
- Stop: CTRL-Z to stop it
- Restart: -c 8 8.8.8.8

This SSH Connect would be used for:
- troubleshooting
- issuing commands
- deploying software
- patching the OS
- changing software


Now, create a Template
Go to Instances > Actions > Images and templates > Create template from instance
- Name it
- Version description
- Auto Scaling guidance = later class session
- AMI = no change
- Instance type = no change
- Key pair = no change
	- there already because its getting settings from the current running EC2 instance
- Subnet = no change
- AZ = no change
	- clue to where your resource is scoped to...this is a ZONAL resource
	- gonna create a us-east-2c and subnet
- Security group = no change
- Storage = no change
- Resource Tags
	- inherited from running EC2
- User data
	- script is already there since this is a template 
- Create Launch Template
- View launch template
- Go to Actions > Create instance from template > Modify template
	- this allows you to change template VERSIONS to...
		- run in a different AZ
		- run a different script (HW)
	- Just change 2 things:
		- add new description
		- replace/update the script (see HW...https://diana-cdn.naturallycurly.com/Articles/N5_SunKissAlba-650px426px.jpg)
		- optional: move to a different AZ (change subnet in Network settings)
	- Now, click Create template version
		- will see that you have a Default Version 1 but a LATEST version 2
	- Now, go to template . Version tab > Version 2 > Launch instance from template
		- you must make sure it's #2 so it won't give you the SAME output.
	- Click Launch Instance
		- click the hyperlink in instance

Click Connect
Type sudo vim index.html
- use Esc>:q to get out
- use Esc :wq to save and exit
Make changes to the script - be careful
-  use Esc :wq to save and exit
Refresh the url...voila!

Edit https://github.com/MookieWAF/bmc4/blob/main/ec2scrpit

