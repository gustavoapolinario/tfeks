# EKS Module

- EKS
  - Public/Private Endpoint
  - Auth configmap configuration
  - Fargante configuration to some namespaces
- Karpenter
  - Public ECR rep
  - Provisioner, AWSNodeTemplate configuration
  - Sample of Deployment to test the karpenter: pause 

## TF Providers

- hashicorp/aws
- hashicorp/helm
- hashicorp/kubernetes
- gavinbunney/kubectl
- terraform-aws-modules/eks/aws
- terraform-aws-modules/eks/aws//modules/karpenter
