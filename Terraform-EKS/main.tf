module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"  # Use a recent version of the module

  cluster_name    = "depooptest-cluster"
  cluster_version = "1.28"  # Updated to a supported version

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Update VPC tags to match your cluster name
  tags = {
    "kubernetes.io/cluster/depooptest-cluster" = "shared"
    Environment = "dev"
    Terraform   = "true"
  }

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t2.medium"]  # Changed to instance_types (plural)
      capacity_type  = "ON_DEMAND"    # Explicitly set capacity type
    }
  }
}