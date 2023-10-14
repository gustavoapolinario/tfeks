resource "kubectl_manifest" "rbac_role_read_only" {
  for_each = toset(split("---", file("${path.module}/rbac-role-read-only.yaml")))
  yaml_body = each.key
}

resource "kubectl_manifest" "rbac_role_dev" {
  for_each = toset(split("---", file("${path.module}/rbac-role-dev.yaml")))
  yaml_body = each.key
}
