# #https://github.com/kubernetes-sigs/aws-ebs-csi-driver/

resource "helm_release" "aws_ebs_csi_driver" {
  depends_on = [ module.ebs_csi_controller_role ]
  name       = "aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  version    = var.helm_chart_version
  namespace  = var.namespace
  create_namespace = true

  # set {
  #   name  = "serviceAccount.create"
  #   value = "true"
  # }

  # set {
  #   name  = "serviceAccount.name"
  #   value = var.service_account_name
  # }


  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.ebs_csi_controller_role.iam_role_arn
  }


}
