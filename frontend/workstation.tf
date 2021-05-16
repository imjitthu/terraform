resource "aws_spot_instance_request" "Frontend" {
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  spot_type = "one-time"  

  connection {
    host = self.public_ip
    user = "root"
    password = "DevOps321"
  }

provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }

output "EC2_Public_IP" {
    value = aws_instance.Frontend.public_ip
    description = "Publisc IP of WorkStation"
}
output "EC2_instance_id" {
  value       = aws_instance.Frontend.id
  description = "EC2 Instance ID"
}

resource "aws_route53_record" "Frontend" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "workstation.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.Frontend.public_ip ]
}

}