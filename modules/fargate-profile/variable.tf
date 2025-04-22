# modules/fargate-profile/variables.tf
variable "cluster_name" {}
variable "subnet_ids" { type = list(string) }
variable "namespace" {}
variable "labels" { type = map(string) }
variable "fargate_pod_execution_role_arn" {}
