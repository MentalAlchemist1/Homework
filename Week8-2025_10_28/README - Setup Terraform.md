 [Readme.md](http://readme.md) or <insert_lizzo_here>.txt document of step by step instructions detailing how to set up and initialize Terraform on your computer. Include what programs to use, what programs not to use, what files should or should not be modified, any Github repos to reference, and relevant commands to get the program running. Instructions should be detailed enough to provide to someone else so they can use the instructions.

### Step 1
Ensure that AWS Agent is installed on your machine properly. Go to terminal run the following command: *aws configure

### Step 2
Ensure that Terraform is installed
- run *terraform --version
	- the version that shows up doesn't matter. Upgrade if you choose but it's not important at this juncture.
- run *brew update && brew upgrade 
	- this may take quite a bit of time. Allow up to 2 hours

### Step 3
Now, there are more prerequisites to run to ensure that your machine is ready to use Terraform.

Run this command in :

curl https://raw.githubusercontent.com/aaron-dm-mcdonald/Class7-notes/refs/heads/main/101825/check.sh | bash

### What the script does
The script checks the following:
- AWS CLI installed, configured and authenticated
- Terraform binary is installed and up to date
- TheoWAF folder present at `~/Documents/TheoWAF/class7/AWS/Terraform`
- Creates a .gitignore file

It will create the TheoWAF folder structure if needed and will download a .gitignore file configured for Terraform projects.

Run the following command to make sure you see the hidden .gitignore file:
- *ls -a
![[Screenshot 2025-10-19 at 2.51.42 PM.png]]

You want to put the .gitignore file into the new folder you just made. You can move (mv) or copy (cp):
- *cp ./.gitignore (target-destination) 
- *ls -a
### Step 4 
Make a directory, cd into it, and then verify that you are in the correct directory by running the following commands:
- *mkdir 10192025
- *cd 10192025
- *ls

Create a file named [0-authentication.tf](http://0-authentication.tf)  by running the following commands in the directory you created above (10192025):
- *touch 0-auth.tf*
- *ls

### Step 5
Open Visual Studio from within Terminal by running the following commands:
- *code . 
- this prompt opens Visual Studio Code. Confirm that you see the [0-authentication.tf](http://0-authentication.tf) file.
- you can now close Terminal and use the code editor within Terraform

### Step 6
Now, it's time to update our terraform files in order to create the VPC we want. Terraform is program that uses declarative language so we have to DECLARE what we want in its parameters.

Go to https://registry.terraform.io/
- You want a Provider that works with Terraform
- Search for AWS
- Search for aws_vpc

![[Screenshot 2025-10-19 at 10.27.23 PM.png]]






### Step XX

Run Terraform workflow

Typical Workflow
1. Write or modify `.tf` files
2. Run `terraform validate` to check syntax
3. Run `terraform plan` to see what will change
4. Review the plan carefully
5. Run `terraform apply` to make the changes
6. Terraform updates the state file automatically

Further Explanation
*terraform init
- Initializes working directory: downloads provider plugins, generates lock file, etc

*terraform validate
- Validate HCL syntax and configuration (check your "grammar", not if it "makes sense" otherwise known as semantically correct)

*terraform plan
- Show execution plan: preview what will change

*terraform apply
- Apply changes: actually create/modify/destroy infrastructure

*terraform destroy
- Destroy all resources managed by this configuration




