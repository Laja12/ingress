# modules/eks/variables.tf
variable "cluster_name" {}
variable "subnet_ids" { type = list(string) }
variable "cluster_role_arn" {}
variable "iam_dependencies" { default = [] }
