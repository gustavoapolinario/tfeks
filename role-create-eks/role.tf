provider "aws" {
  region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "eks_creation_role" {
  name = "eks_creation_role"
  max_session_duration = 3600

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${data.aws_caller_identity.current.arn}"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_creation_role_policy" {
  role       = aws_iam_role.eks_creation_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
