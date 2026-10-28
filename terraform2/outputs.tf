output "server_ip_1" {
  value = aws_instance.my_server_1.public_ip
}

output "ssm_command_1" {
  value = "aws ssm start-session --target ${aws_instance.my_server_1.id}"
}