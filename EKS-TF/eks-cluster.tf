resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.EKSClusterRole.arn

  vpc_config {
    subnet_ids = aws_subnet.private[*].id   # ✅ ONLY private subnets

    security_group_ids = [data.aws_security_group.sg_default.id]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  version = "1.28"

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}
