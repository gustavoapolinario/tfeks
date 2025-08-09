## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.20 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.11 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.20 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.11 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.4 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.kubernetes_alb_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.kubernetes_alb_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.kubernetes_alb_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.alb_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [local_file.aws-lb-controller-policy](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_iam_policy_document.kubernetes_alb_controller_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [http_http.aws-lb-controller-policy](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_lb_controller_version"></a> [aws\_lb\_controller\_version](#input\_aws\_lb\_controller\_version) | ALB Controller Helm chart version. | `string` | `"2.6.1"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region where secrets are stored. | `string` | n/a | yes |
| <a name="input_cluster_identity_oidc_issuer"></a> [cluster\_identity\_oidc\_issuer](#input\_cluster\_identity\_oidc\_issuer) | The OIDC Identity issuer for the cluster. | `string` | n/a | yes |
| <a name="input_cluster_identity_oidc_issuer_arn"></a> [cluster\_identity\_oidc\_issuer\_arn](#input\_cluster\_identity\_oidc\_issuer\_arn) | The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | ALB Controller Helm chart version. | `string` | `"1.4.6"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy ALB Controller Helm chart. | `string` | `"lb-controller"` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | ALB Controller service account name | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Additional settings which will be passed to the Helm chart values. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_loadbalancer_controller_namespace"></a> [helm\_loadbalancer\_controller\_namespace](#output\_helm\_loadbalancer\_controller\_namespace) | n/a |
| <a name="output_helm_loadbalancer_controller_version"></a> [helm\_loadbalancer\_controller\_version](#output\_helm\_loadbalancer\_controller\_version) | n/a |
| <a name="output_lb-controller-role"></a> [lb-controller-role](#output\_lb-controller-role) | Role to Load Balancer Controller use to create and configure the load balancers |
