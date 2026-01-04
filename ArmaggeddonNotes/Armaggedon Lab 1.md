Student Deliverables:

1. Screenshot of: RDS SG inbound rule using source = sg-ec2-lab EC2 role attached /list output showing at least 3 notes
2. Short answers: A) Why is DB inbound source restricted to the EC2 security group? B) What port does MySQL use? C) Why is Secrets Manager better than storing creds in code/user-data?

Steps:
1. Create VPC:
    - choose VPC and more
    - select VPC CIDR block
    - choose at least **2** AZ's (the RdDS DB, requires at least two)
    - Set each subnet CIDR block
    - NAT gateway is not needed for the this simple setup (pubic subnet EC2 will use IGW)
    - S3 Gateway not needed
    - Enable DNS Hostnames & DNS Resolution
    
2. Create  security group:
    - This is for EC2 to be accessible by HTTP and SSH
    - Allows IPv4 anywhere for inbound HTTP and SSH (you can limit to your IP)
    - we're NOT going to make a SG for the RDS
    - SSH = my 100.15.69.47/32
    - HTTP = Anywhere ipv2
    
3. Policy & Roles to allows EC2 to get secret:
    - For this will create the need permissions policy first, then attach it to the role along with the proper principal,
    - permission policy: alex_inline_policy, us-west-2, 262164343754
 ```
 {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ReadSpecificSecret",
      "Effect": "Allow",
      "Action": ["secretsmanager:GetSecretValue"],
      "Resource": "arn:aws:secretsmanager:<REGION>:<ACCOUNT_ID>:secret:lab/rds/mysql*"
    }
  ]
}
``` 

N.B. Ensure to make the necessary changes for `<REGION>` and `<ACCOUNT_ID>`, also take note of the `lab/rds/mysql` as this needs to be the exact secrets name in Secrets Manager.

Create role and attach to policy
- alex_armaggeddon_role
- alex_inline_policy
- check 

![[Screenshot 2026-01-02 at 7.37.12 PM.png]]
![[Screenshot 2026-01-02 at 7.41.09 PM.png]]
![[Screenshot 2026-01-02 at 7.42.01 PM.png]]
 4. EC2 creations:
    - Default setting for AMI (Amazon Linux 2023)
    - Default instance type and settings
    - create key pair
    - Choose created VPC, public subnet, and public security group
    - enable 'Auto-assign public IP'
    - Double-check, pray, then launch instance

name: lab-ec2-app
key pair: alex_armaggeddon_key_pair
alex_armaggeddon-vpc
alex_armaggeddon-subnet-public-1
sg = alex_armaggeddon
enable = auto-assign public IP
i-0d957eede4286928f (lab-ec2-app)

don't need to make another sg
ec2, vpc is ready at this point
rds creation will automatically make a sg


5. Attach role to instance:
    - steps = Instance  > Actions > Security > Modify IAM Role
    - Then attach the role you just created under 'IAM Role'
    - The click 'Update IAM Role'
    ![[Screenshot 2026-01-02 at 7.52.39 PM.png]]
Before creating RDS, copy ipv4 and copy into browser
![[Screenshot 2026-01-02 at 7.54.30 PM.png]]
6. Create RDS Database:
    - Go to create database under 'Aurora and RDS'
    - Go 'Full Configuration'
    - Then "MySQL"
    - Then Choose 'Free Tier'
    - Choose DB Instance Identifier ('lab-mysql')
    - Choose Master username ('admin')
    - Then select 'Self Managed' for 'Credentials management'
    - Then create and remember your password ('TestArm432') {this a test, make your own} = <font color="#ff0000">KingKong2026!</font>
    - Then leave setting default until Connectivity, select "Connect to and EC2 compute resource"
    - Choose the created EC2 under 'EC2 Instance'
    - VPC should be automatically selected
    - DB Subnet Group, choose automatic setup
    - Public Access = 'No'
    - For VPC Security Group check 'Create New'
    - Enable Logs then 'Create Database'
    ![[Screenshot 2026-01-02 at 8.09.01 PM.png]]
Make note of endpoint: lab-mysql.cl02ec282asu.us-west-2.rds.amazonaws.com

7. Create Secret in Secrets Manager
    -  Under Secrets Manager, select 'Store a New Secret'
    - 'Secret Type' is Credentials for Amazon RDS Database
    - Credentials, User name = 'admin' (or your choice)
    - Credentials, Password = 'you specific password'
    - Then select your created DB, then click next
    - Set Secret Name to be same as in policy and application script = lab/rds/mysql*
    - Then click until you reach review (leave configuration rotation as default),
    - Review and then 'Store' your secret.

Connected to the Instance:

![[Screenshot 2026-01-02 at 8.22.25 PM.png]]

put in EC2
aws secretsmanager get-secret-value --secret-id lab/rds/mysql


![[Screenshot 2026-01-02 at 8.24.26 PM.png]]
EC2 connects to secrets manager
got everything

mysql -h <RDS_ENDPOINT> -u admin -p
- endpoint: lab-mysql.cl02ec282asu.us-west-2.rds.amazonaws.com
- logs us into db itself
- We're IN!!
![[Screenshot 2026-01-02 at 8.28.46 PM.png]]


![[Screenshot 2026-01-02 at 8.34.18 PM.png]]


![[Screenshot 2026-01-02 at 8.42.12 PM.png]]
- CREATE DATABASE labdb;

systemctl start rdsapp

sudo systemctl restart rdsapp

![[Screenshot 2026-01-02 at 8.48.17 PM.png]]

![[Screenshot 2026-01-02 at 8.51.31 PM.png]]

![[Screenshot 2026-01-02 at 8.54.24 PM.png]]

