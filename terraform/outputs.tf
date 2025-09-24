output "frontend" {
  value = {
    hostname   = "c8.local"
    public_ip  = aws_instance.c8.public_ip
    private_ip = aws_instance.c8.private_ip
  }
}

output "backend" {
  value = {
    hostname   = "u21.local"
    public_ip  = aws_instance.u21.public_ip
    private_ip = aws_instance.u21.private_ip
  }
}
