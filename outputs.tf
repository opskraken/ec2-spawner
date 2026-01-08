output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.app_server[*].id
}

output "public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.app_server[*].public_ip
}

output "instance_urls" {
  description = "URLs to access the web servers"
  value       = [for ip in aws_instance.app_server[*].public_ip : "http://${ip}"]
}

output "ssh_connection_strings" {
  description = "Commands to connect to the instances via SSH"
  value       = [for ip in aws_instance.app_server[*].public_ip : "ssh -i ${replace(var.public_key_path, ".pub", "")} ubuntu@${ip}"]
}
