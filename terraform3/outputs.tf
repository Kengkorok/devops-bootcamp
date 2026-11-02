output "server_ip_public" {
  value = aws_instance.my_server_1.public_ip
}

output "ssm_command_public" {
  value = "aws ssm start-session --target ${aws_instance.my_server_1.id}"
}

output "ssm_command_private" {
  value = "aws ssm start-session --target ${aws_instance.my_server_2.id}"
}