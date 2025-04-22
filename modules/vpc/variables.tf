# modules/vpc/variables.tf
variable "cidr" {}
variable "private_subnet_cidrs" { type = list(string) }
variable "azs" { type = list(string) }
variable "name" {}
