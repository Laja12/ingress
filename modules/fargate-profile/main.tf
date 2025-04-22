# modules/fargate-profile/main.tf
resource "aws_eks_fargate_profile" "this" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = "fargate-cluster-profile"
  pod_execution_role_arn = aws_iam_role.fargate_pod_execution.arn
  subnet_ids             = var.subnet_ids

  selector {
    namespace = var.namespace
    labels    = var.labels
  }
}
resource "aws_iam_role" "fargate_pod_execution" {
  name = "fargate-pod-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "fargate_pod_execution_attach" {
  role       = aws_iam_role.fargate_pod_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

