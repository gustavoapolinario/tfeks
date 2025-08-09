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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ebs_csi_controller_role"></a> [ebs\_csi\_controller\_role](#module\_ebs\_csi\_controller\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [helm_release.aws_ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [local_file.aws-ebs-csi-driver-policy](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [http_http.aws-ebs-csi-driver-policy](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_identity_oidc_provider"></a> [cluster\_identity\_oidc\_provider](#input\_cluster\_identity\_oidc\_provider) | The OIDC Identity provider for the cluster. | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | EBS CSI Driver Helm chart version. | `string` | `"v1.23.1"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace to deploy the EBS CSI Driver Helm chart. | `string` | `"kube-system"` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | EBS CSI Driver Service Account Name | `string` | `"ebs-csi-controller-sa"` | no |

## Outputs

No outputs.
