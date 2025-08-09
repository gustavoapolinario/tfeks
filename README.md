## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.11 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.21.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.23.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_eks-ebs-csi-driver"></a> [eks-ebs-csi-driver](#module\_eks-ebs-csi-driver) | ./modules/eks-ebs-csi-driver | n/a |
| <a name="module_eks-external-secrets"></a> [eks-external-secrets](#module\_eks-external-secrets) | ./modules/eks-external-secrets | n/a |
| <a name="module_eks_loadbalancer"></a> [eks\_loadbalancer](#module\_eks\_loadbalancer) | ./modules/eks-load-balancer-controller | n/a |
| <a name="module_eks_rbac_default_roles"></a> [eks\_rbac\_default\_roles](#module\_eks\_rbac\_default\_roles) | ./modules/eks-rbac-default-roles | n/a |
| <a name="module_terraform_state_backend"></a> [terraform\_state\_backend](#module\_terraform\_state\_backend) | cloudposse/tfstate-backend/aws | 1.1.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_namespace.es_secret_store_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster_auth.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_all_outputs"></a> [all\_outputs](#input\_all\_outputs) | (Optional) Show all outputs? Hide modules output | `bool` | `true` | no |
| <a name="input_auth_roles"></a> [auth\_roles](#input\_auth\_roles) | (Optional) Auth Map Roles to be created on EKS | `list` | `[]` | no |
| <a name="input_auth_users"></a> [auth\_users](#input\_auth\_users) | (Optional) Auth Map Users to be created on EKS | `list` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to run the EKS | `string` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | (Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id` | `string` | `"10.0.0.0/16"` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | (Optional) Cluster Endpoint with public access | `bool` | `false` | no |
| <a name="input_create_nat_gateway"></a> [create\_nat\_gateway](#input\_create\_nat\_gateway) | Create the Nat gateway? | `bool` | `false` | no |
| <a name="input_create_state_storage"></a> [create\_state\_storage](#input\_create\_state\_storage) | (Optional) Create the state storage S3 and DynamoDB to save the state and lock? | `bool` | `true` | no |
| <a name="input_create_subnet_data"></a> [create\_subnet\_data](#input\_create\_subnet\_data) | Create the data subnet? | `bool` | `true` | no |
| <a name="input_create_subnet_private"></a> [create\_subnet\_private](#input\_create\_subnet\_private) | Create the private subnet? | `bool` | `true` | no |
| <a name="input_create_subnet_public"></a> [create\_subnet\_public](#input\_create\_subnet\_public) | Create the public subnet? | `bool` | `true` | no |
| <a name="input_enable_flow_log"></a> [enable\_flow\_log](#input\_enable\_flow\_log) | Whether or not to enable VPC Flow Logs | `bool` | `false` | no |
| <a name="input_es_secret_store_namespace"></a> [es\_secret\_store\_namespace](#input\_es\_secret\_store\_namespace) | Namespaces to create the external secrets secret store | `list(string)` | n/a | yes |
| <a name="input_ipv6_cidr"></a> [ipv6\_cidr](#input\_ipv6\_cidr) | (Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length` | `string` | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes Version | `string` | n/a | yes |
| <a name="input_one_nat_gateway_per_az"></a> [one\_nat\_gateway\_per\_az](#input\_one\_nat\_gateway\_per\_az) | One Nat per AZ? | `bool` | `true` | no |
| <a name="input_qtt_az"></a> [qtt\_az](#input\_qtt\_az) | Number of Zones to use | `number` | `3` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | DynamoDB table ARN |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | DynamoDB table ID |
| <a name="output_dynamodb_table_name"></a> [dynamodb\_table\_name](#output\_dynamodb\_table\_name) | DynamoDB table name |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | S3 bucket ARN |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | S3 bucket domain name |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 bucket ID |
| <a name="output_s3_replication_role_arn"></a> [s3\_replication\_role\_arn](#output\_s3\_replication\_role\_arn) | The ARN of the IAM Role created for replication, if enabled. |
| <a name="output_terraform_backend_config"></a> [terraform\_backend\_config](#output\_terraform\_backend\_config) | Rendered Terraform backend config file |
