output "tf-public_server_public_ip" {
    value = aws_instance.tf-server-1.public_ip
    description = "it displays public ip of the instance"
}