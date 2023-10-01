# Caution

The .gitignore file are not ignoring the .tfvars
if you fork the repository make sure to uncomment this ignore pattern

# Introduction

This repository is a lab to test Terraform/OpenTofu with EKS

## TF Modules

hashicorp/aws
terraform-aws-modules/vpc/aws

## VPC

For the VPC, I'm using the module terraform-aws-modules to easely create everything
You can set the variables to customize the VPC creation


# How to start

## Prepare your project

This command will install the providers needed for the project

```
terraform init
```

## Analyse the changes

This command will show the plan of execution with all changes

```
terraform plan
```

## Apply all changes

This command will apply all changes maide in your IaC tf files to your environment

```
terraform apply
```

# how to remove everything?

For exclude everything, use this command:

```
terraform destroy
```
