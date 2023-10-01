# Caution

The .gitignore file are not ignoring the .tfvars
if you fork the repository make sure to uncomment this ignore pattern

# The Project

This repository is a lab to test Terraform/OpenTofu with EKS

## TF Providers

- hashicorp/aws
- hashicorp/helm
- hashicorp/kubernetes
- gavinbunney/kubectl
- terraform-aws-modules/eks/aws
- terraform-aws-modules/eks/aws//modules/karpenter

## Modules

### VPC

[README](modules/vpc/README.md)

### EKS

[README](modules/eks/README.md)


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
