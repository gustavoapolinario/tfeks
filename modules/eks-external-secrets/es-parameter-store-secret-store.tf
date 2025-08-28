resource "kubectl_manifest" "es_parameter_store_secret_store_deployment" {
  depends_on = [
    aws_iam_role_policy_attachment.external_secrets,
    kubernetes_service_account.es_parameter_store_sa,
    helm_release.external_secrets
  ]

  for_each = toset(var.secret_store_namespace)

  yaml_body = <<-YAML
    apiVersion: external-secrets.io/v1beta1
    kind: SecretStore
    metadata:
      name: aws-parameterstore
      namespace: ${each.key}
    spec:
      # controller: parameter-store
      provider:
        aws:
          service: ParameterStore
          region: ${var.aws_region}
          auth:
            jwt:
              serviceAccountRef:
                name: ${var.service_account_name}
  YAML
}
