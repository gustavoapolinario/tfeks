module "ebs_csi_controller_role" {
  depends_on = [ aws_iam_policy.ebs_csi_driver ]
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  create_role                   = true
  role_name                     = "${var.cluster_name}-ebs-csi-controller"
  provider_url                  = var.cluster_identity_oidc_provider
  role_policy_arns              = [
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    aws_iam_policy.ebs_csi_driver.arn
  ]
  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.namespace}:${var.service_account_name}"]
}

data "http" "aws-ebs-csi-driver-policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/helm-chart-aws-ebs-csi-driver-${var.helm_chart_version}/docs/example-iam-policy.json"

  request_headers = {
    Accept = "application/json"
  }
}

resource "local_file" "aws-ebs-csi-driver-policy" {
  depends_on  = [data.http.aws-ebs-csi-driver-policy]
  content  = data.http.aws-ebs-csi-driver-policy.response_body
  filename = "${path.module}/ebs-csi-driver-iam-policy.json"
}

resource "aws_iam_policy" "ebs_csi_driver" {
  depends_on  = [data.http.aws-ebs-csi-driver-policy]
  name        = "${var.cluster_name}-ebs-csi-driver"
  path        = "/"
  description = "Policy for EBS CSI driver service"

  policy = data.http.aws-ebs-csi-driver-policy.response_body
}

# resource "aws_iam_role_policy_attachment" "kubernetes_alb_controller" {
#   role       = aws_iam_role.ebs_csi_controller_role.name
#   policy_arn = aws_iam_policy.ebs_csi_driver.arn
# }

# resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
#   role       = aws_iam_role.ebs_csi_driver.name
#   policy_arn = [
#     "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
#     aws_iam_policy.ebs_csi_driver.arn
#   ]
# }

    # aws-ebs-csi-driver = {
    #   service_account_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.name}-ebs-csi-controller"
    #   addon_version = "v1.23.1-eksbuild.1"
    #   resolve_conflicts="PRESERVE"
    # }
