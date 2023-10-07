output "helm_external_secrets_version" {
    value = helm_release.external_secrets.version
}

output "helm_external_secrets_namespace" {
    value = helm_release.external_secrets.namespace
}
