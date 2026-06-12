# Web Server Public IP
output "web_public_ip" {
  description = "Public IP of Web Server"
  value       = aws_instance.web_server.public_ip
}

# DB Server Private IP
output "db_private_ip" {
  description = "Private IP of DB Server"
  value       = aws_instance.db_server.private_ip
}
