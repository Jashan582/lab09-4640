# 4640-w9-lab-start-w25


# The first thing we need to do is import our ssh key into aws
# We can do this using the following command 

.scripts/import_lab_key ~/.ssh/aws-4640.pub

# Then we add all the nessarry configuration information in the packer file ansible-packer.hcl.pck
# and run the command 

packer validate

# you should see a return of 

The configuration is valid.

# if everything looks good then we can run 

packer build . 

# you should see a big long message ending with something like 

==> Builds finished. The artifacts of successful builds are:
--> web-nginx.amazon-ebs.ubuntu: AMIs were created:
us-west-2: ami-0e549e5431d9ea42f

# And a ami should be created in the region you specified
![image](https://github.com/user-attachments/assets/8f67292f-6ab3-45b8-b0b2-e69f6076336a)

# Then we want to cd into our terraform directory and run the commands 

Terraform init

and Terrafrom appy 

# This should not bring  up our ec2 instance from the ami image
