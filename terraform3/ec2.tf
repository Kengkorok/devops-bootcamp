data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_iam_instance_profile" "my_ssm_profile" {
  name = "EC2-SSM-Role"
}

resource "aws_instance" "my_server_1" {
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.public_subnets[0]
  vpc_security_group_ids = [module.my_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name
  user_data              = templatefile("userdata.sh", {})

  tags = {
    Name = "tf-server-1"
  }
}
resource "aws_instance" "my_server_2" {
  ami                    = data.aws_ami.my_ami.id
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.private_subnets[0]
  vpc_security_group_ids = [module.my_sg.id]
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name

  tags = {
    Name = "tf-server-2"
  }
}