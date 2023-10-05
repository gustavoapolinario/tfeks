resource "kubernetes_manifest" "rbac_role_read_only" {
  for_each = toset(split("---", file("${path.module}/rbac-role-read-only.yaml")))
  manifest = yamldecode(each.key)
}

resource "kubernetes_manifest" "rbac_role_dev" {
  for_each = toset(split("---", file("${path.module}/rbac-role-dev.yaml")))
  manifest = yamldecode(each.key)
}
