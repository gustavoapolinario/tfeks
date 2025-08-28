resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  chart            = "external-secrets"
  repository       = "https://charts.external-secrets.io"
  version          = var.helm_chart_version
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_secrets.arn
  }
}
