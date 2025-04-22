# modules/eks/outputs.tf
output "cluster_name" {
  value = aws_eks_cluster.this.name
}
