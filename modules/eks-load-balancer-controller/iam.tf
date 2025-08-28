data "http" "aws-lb-controller-policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v${var.aws_lb_controller_version}/docs/install/iam_policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "local_file" "aws-lb-controller-policy" {
  depends_on = [data.http.aws-lb-controller-policy]
  content    = data.http.aws-lb-controller-policy.response_body
  filename   = "${path.module}/downloaded-iam-policy.json"
}

resource "aws_iam_policy" "kubernetes_alb_controller" {
  depends_on  = [data.http.aws-lb-controller-policy]
  name        = "${var.cluster_name}-alb-controller"
  path        = "/"
  description = "Policy for load balancer controller service"

  policy = data.http.aws-lb-controller-policy.response_body
}

# Role
data "aws_iam_policy_document" "kubernetes_alb_controller_assume" {

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.cluster_identity_oidc_issuer_arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_identity_oidc_issuer, "https://", "")}:sub"

      values = [
        "system:serviceaccount:${var.namespace}:${var.service_account_name}",
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.cluster_identity_oidc_issuer, "https://", "")}:aud"

      values = [
        "sts.amazonaws.com"
      ]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "kubernetes_alb_controller" {
  name               = "${var.cluster_name}-alb-controller"
  assume_role_policy = data.aws_iam_policy_document.kubernetes_alb_controller_assume.json
}

resource "aws_iam_role_policy_attachment" "kubernetes_alb_controller" {
  role       = aws_iam_role.kubernetes_alb_controller.name
  policy_arn = aws_iam_policy.kubernetes_alb_controller.arn
}
