resource "aws_spot_instance_request" "Frontend" {
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  spot_type = "one-time"  

  tags = {
    "Name" = "${var.COMPONENT}"
  }

connection {
type = "ssh"
user = "root"
password = "DevOps321"
}
provisioner "file" {
    when = create
    source      = "files/*"
    destination = "/root/www/"
  }
provisioner "file" {
    source      = "templates/nginx.conf"
    destination = "/etc/nginx/default.d/roboshop.conf"
  }
provisioner "local-exec" {
    when = create
    inline = [
      "set-hostname Frontend",
      "yum install nginx -y",
      "systemctl enable nginx",
      "systemctl restart nginx",
    ]
}

}


output "EC2_Public_IP" {
    value = aws_spot_instance_request.Frontend.public_ip
    description = "Publisc IP of WorkStation"
}
output "EC2_instance_id" {
  value       = aws_spot_instance_request.Frontend.id
  description = "EC2 Instance ID"
}
resource "aws_route53_record" "Frontend" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "workstation.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_spot_instance_request.Frontend.public_ip ]
}

