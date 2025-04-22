module "vpc" {
  source = "./modules/vpc"
  name   = "eks-fargate"
  cidr   = "10.0.0.0/16"
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  azs = ["us-west-1a", "us-west-1b"]
}

module "iam" {
  source = "./modules/iam"
  name   = "eks-fargate"
}

module "eks" {
  source = "./modules/eks"
  cluster_name     = "eks-fargate-cluster"
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
  iam_dependencies = [module.iam]
}

module "fargate_profile" {
  source = "./modules/fargate-profile"
  cluster_name                  = module.eks.cluster_name
  subnet_ids                    = module.vpc.private_subnet_ids
  namespace                     = "default"
  labels                        = { "run" = "fargate-app" }
  fargate_pod_execution_role_arn = module.iam.cluster_role_arn # You’d create a different role in real cases
}
