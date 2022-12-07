# Example AWS Terraform 

This example creates a single public facing web server and dedicated VPC.  This uses a "public" subnet, but is utilizing a private subnet space to avoiding using up Elastic IPs.  It also utilizes Terraform workspaces to maintain state for separate environments.  The environments in this example are "env1" and "env2". 

## Prerequisites

- export AWS_ACCESS_KEY_ID
- export AWS_SECRET_ACCESS_KEY
- create an AWS SSH key pair named "test-web" (or update the env1.tfvars)

## Steps:
- terraform workspace new env1
- terraform workspace new env2
- terraform workspace select env1
- terraform init
- terraform apply