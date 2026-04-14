resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eksnode_group_name
  node_role_arn   = aws_iam_role.NodeGroupRole.arn

  subnet_ids = aws_subnet.private[*].id   # ✅ ALL 3 private subnets

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t2.medium"]
  disk_size      = 20

  capacity_type = "ON_DEMAND"   # optional (can use SPOT also)

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]

  tags = {
    Name = "eks-node-group"
  }
}
