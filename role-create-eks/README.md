# Introduction

Create the AWS Role before create the EKS.

# Motivation

If you lost the access on EKS, you can recreate the creation role, assume it and get access on EKS again

# How to do

## Creating the cluste with the role

On role-create-eks folder, prepare the terraform and apply it.

```
cd role-create-eks
terraform init
terraform apply
```

## Configure the main project

Get the outputs generated

Go to the main project and put the role on provider.tf

ex:

```
provider "aws" {
  ...
  assume_role {
    role_arn    = "arn:aws:iam::66666666:role/eks_creation_role"
    external_id = "eks_creation_role"
  }
}
```

Go on the tfvars and put the auth_user/auth_role

It is necessary to give access to your default user/role on cluster

ex:
```
auth_roles = {
  "groups" = [
    "system:bootstrappers",
    "system:nodes",
  ]
  "rolearn" = "arn:aws:iam::66666666:role/myrole"
  "username" = "system:node:{{EC2PrivateDNSName}}"
}
```


## After create the EKS, delete the role to never use it more, only in incident

```
cd role-create-eks
terraform destroy
```

and comment again the assume_role on provider.tf

ex:

```
provider "aws" {
  ...
  # assume_role {
  #   role_arn    = "arn:aws:iam::66666666:role/eks_creation_role"
  #   external_id = "eks_creation_role"
  # }
}
```
