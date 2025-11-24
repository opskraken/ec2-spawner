output "instance_id" {
description = ""
value       = aws_instance.instant_app_server.id
}

output "public_ip" {
description = ""
value       = aws_instance.instant_app_server.public_ip
}

output "instance_url" {
description = ""
value       = "http://${aws_instance.instant_app_server.public_ip}"
}