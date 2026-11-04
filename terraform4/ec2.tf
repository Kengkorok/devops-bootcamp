data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

module "my_server_rackula" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.4"

  name      = "tf-server-rackula"
  ami       = data.aws_ami.my_ami.id
  # t3.micro = 2 vCPU / 1 GB RAM. Container Rackula ada limit 128M (UI) + 64M (API).
  instance_type          = "t3.micro"
  subnet_id              = module.my_vpc.public_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.my_sg.id]

  # SSM: AmazonSSMManagedInstanceCore ditatch pada role dalam iam.tf
  iam_instance_profile = aws_iam_instance_profile.rackula_ssm.name

  # user_data jalan sekali masa instance dicipta. Set true supaya bila script
  # ni diedit, terraform recreate instance dan script jalan semula.
  user_data                   = file("userdata.sh")
  user_data_replace_on_change = true

  tags = { Name = "tf-server-rackula" }
}
