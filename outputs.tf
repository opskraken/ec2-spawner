output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.app_server[*].id
}

output "public_ips" {
  description = "Public IP addresses of the EC2 instances (dynamic)"
  value       = aws_instance.app_server[*].public_ip
}

output "elastic_ips" {
  description = "Elastic IP addresses (persistent - use these for connections)"
  value       = aws_eip.app_eip[*].public_ip
}

output "instance_urls" {
  description = "URLs to access the web servers using Elastic IPs"
  value       = [for ip in aws_eip.app_eip[*].public_ip : "http://${ip}"]
}

output "private_key_pem" {
  description = "Private key in PEM format (Sensitive)"
  value       = tls_private_key.pk.private_key_pem
  sensitive   = true
}

output "ssh_connection_strings" {
  description = "Commands to connect to the instances via SSH using Elastic IPs"
  value       = [for ip in aws_eip.app_eip[*].public_ip : "echo '${tls_private_key.pk.private_key_pem}' > key.pem && chmod 400 key.pem && ssh -i key.pem ubuntu@${ip}"]
  sensitive   = true
}
