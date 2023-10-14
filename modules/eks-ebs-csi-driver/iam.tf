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
  filename = "${path.module}/downloaded-ebs-csi-driver-iam-policy.json"
}

resource "aws_iam_policy" "ebs_csi_driver" {
  depends_on  = [data.http.aws-ebs-csi-driver-policy]
  name        = "${var.cluster_name}-ebs-csi-driver"
  path        = "/"
  description = "Policy for EBS CSI driver service"

  policy = data.http.aws-ebs-csi-driver-policy.response_body
}
