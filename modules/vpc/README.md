# VPC Module

- Hight Availability VPC creation
- ipv4 and ipv6
- Nat in each zone
- public, private and database subnets
- Elastic IP created out of vpc. If delete the vpc, the EIP is not lost
- @TODO: flow logs to S3

## TF Providers

hashicorp/aws

terraform-aws-modules/vpc/aws

## VPC

For the VPC, I'm using the module terraform-aws-modules to easely create everything
You can set the variables to customize the VPC creation
