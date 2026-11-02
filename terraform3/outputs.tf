output "server_ip_public" {
  value = module.my_server_public.public_ip
}

output "ssm_command_public" {
  value = "aws ssm start-session --target ${module.my_server_public.id}"
}

output "ssm_command_private" {
  value = "aws ssm start-session --target ${module.my_server_private.id}"
}
