## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.eks_creation_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.eks_creation_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assume_role"></a> [assume\_role](#output\_assume\_role) | Assume role to put on main.tf file to assume role and create the eks as this role |
| <a name="output_auth_roles"></a> [auth\_roles](#output\_auth\_roles) | Auth role to put on terraform.tfvars file to give access on eks to original role |
| <a name="output_auth_users"></a> [auth\_users](#output\_auth\_users) | Auth user to put on terraform.tfvars file to give access on eks to original role |
| <a name="output_eks_creation_role"></a> [eks\_creation\_role](#output\_eks\_creation\_role) | AWS Role to Create the EKS only. It is necessary to follow the best practices and recovery access in case of lost access on RBAC |
