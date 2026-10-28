resource "aws_security_group" "my_sg" {
  name   = "tf-web-sg"
  vpc_id = aws_vpc.my_vpc.id
  tags = { Name = "tf-web-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "my_inbound_rule" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "my_outbound_rule" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}