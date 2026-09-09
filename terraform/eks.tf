data "aws_instances" "eks_managed_node_groups" {
  filter {
    name   = "tag:kubernetes.io/cluster/${local.name}" 
    values = ["owned"]
  }

  instance_state_names = ["running"]
}
module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "~> 20.0"
  cluster_name                             = local.name
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  cluster_security_group_additional_rules = {
    ec2_to_cluster_api = {
      description              = "Allow EC2 Jenkins host to access EKS API"
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = aws_security_group.easyshop_sg.id
    }
  }
  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {
    instance_types                        = ["t3.small"]
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    easyshop-ng = {
      name = "easyshop-ng"
      desired_size               = 2
      min_size                   = 2
      max_size                   = 3
      instance_types             = ["t3.small"]
      disk_size                  = 20
      capacity_type              = "SPOT"
      use_custom_launch_template = false
      aws_security_group.easyshop_sg.id
      additional_tags = {
        Name = "easyshop-ng"
      }
    }
  }
}
