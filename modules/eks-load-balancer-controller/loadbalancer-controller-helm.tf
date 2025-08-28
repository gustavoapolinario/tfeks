#https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases
#https://github.com/aws/eks-charts/tree/master/stable/aws-load-balancer-controller
#https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html

resource "helm_release" "alb_controller" {
  name             = "aws-load-balancer-controller"
  chart            = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  version          = var.helm_chart_version
  namespace        = var.namespace
  create_namespace = true

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = var.service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.kubernetes_alb_controller.arn
  }

  set {
    name  = "enableServiceMutatorWebhook"
    value = "false"
  }

  values = [
    yamlencode(var.settings)
  ]

}
