output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "instance_url" {
  description = "URL to access the web server"
  value       = "http://${aws_instance.app_server.public_ip}"
}

output "private_key_pem" {
  description = "Private key in PEM format (Sensitive)"
  value       = tls_private_key.pk.private_key_pem
  sensitive   = true
}

output "ssh_connection_string" {
  description = "Command to connect to the instance via SSH"
  value       = "echo '${tls_private_key.pk.private_key_pem}' > key.pem && chmod 400 key.pem && ssh -i key.pem ec2-user@${aws_instance.app_server.public_ip}"
  sensitive   = true
}
