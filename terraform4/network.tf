module "my_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.7"

  name = "tf-rackula-vpc"
  cidr = "10.20.0.0/16"
  azs  = ["ap-southeast-1a"]

  # Satu public subnet sahaja - Rackula duduk terus kat sini (tiada private subnet)
  public_subnets = ["10.20.1.0/24"]

  map_public_ip_on_launch = true
  enable_nat_gateway      = false
}
