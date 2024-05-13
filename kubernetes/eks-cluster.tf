module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"  # Update to the new version

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent                    = true
      resolve_conflicts_on_create    = "OVERWRITE"
    }
    kube-proxy = {
      most_recent                    = true
      resolve_conflicts_on_create    = "OVERWRITE"
    }
    vpc-cni = {
      most_recent                    = true
      resolve_conflicts_on_create    = "OVERWRITE"
    }
  }

  cluster_name    = "myAppp-eks-cluster"
  cluster_version = "1.27"  # Update if a new Kubernetes version is available

  subnet_ids = module.myAppp-vpc.private_subnets
  vpc_id     = module.myAppp-vpc.vpc_id

  tags = {
    environment = "development"
    application = "myAppp"
  }

  eks_managed_node_groups = {
    dev = {
      min_size       = 1
      max_size       = 6
      desired_size   = 3
      instance_types = ["t2.small"]
      key_name       = "ohio"
  }
}

}
