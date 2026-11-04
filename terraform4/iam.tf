# Peranan IAM untuk SSM - instance boleh didaftarkan sebagai managed instance
# tanpa SSH key / security group masuk port 22.

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rackula_ssm" {
  name               = "rackula-ec2-ssm-role"
  description        = "Role untuk EC2 Rackula register ke AWS Systems Manager"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = { Name = "rackula-ec2-ssm-role" }
}

# AWS managed policy ni yang bagi akses Session Manager + Run Command
# ARN: arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
resource "aws_iam_role_policy_attachment" "rackula_ssm_core" {
  role       = aws_iam_role.rackula_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "rackula_ssm" {
  name = "rackula-ec2-instance-profile"
  role = aws_iam_role.rackula_ssm.name

  tags = { Name = "rackula-ec2-instance-profile" }
}
