output "rackula_url" {
  description = "URL Rackula (buka dalam browser)"
  value       = "http://${module.my_server_rackula.public_ip}:8080"
}

output "instance_id" {
  description = "ID instance EC2 (untuk SSM)"
  value       = module.my_server_rackula.id
}

output "ssm_command" {
  description = "Shell tanpa SSH (perlu Session Manager plugin pada PC)"
  value       = "aws ssm start-session --target ${module.my_server_rackula.id}"
}
