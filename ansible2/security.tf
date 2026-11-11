data "http" "myip" {
  url = "https://api.ipify.org"
}

module "my_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "tf-vpc-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id

  ingress_rules = {
    http = {
      cidr_ipv4   = "0.0.0.0/0"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
    }
    ssh = {
      cidr_ipv4   = "${chomp(data.http.myip.response_body)}/32"
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
    }
  }

  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1" }
  }

  tags = { Name = "tf-vpc-sg" }
}
