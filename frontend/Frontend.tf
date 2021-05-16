resource "aws_spot_instance_request" "frontend" {
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  spot_type = "one-time"  

  tags = {
    "Name" = "${var.COMPONENT}"
  }
  # connection {
  #   host = self.private_ip
  # }
provisioner "remote-exec" {
    when = create
    inline = [
      "set-hostname frontend",
      "yum install nginx -y",
      "systemctl enable nginx",
      "systemctl restart nginx",
    ]
}
provisioner "file" {
    when = create
    source      = "files/index.html"
    destination = "/root/www/index.html"
  }
provisioner "file" {
    source      = "templates/roboshop.conf"
    destination = "/etc/nginx/default.d/roboshop.conf"
  }

provisioner "file" {
  source        = "templates/nginx.conf"
  destination   = "/etc/nginx/nginx.conf"
}
  connection {
    host = "aws_spot_instance_request.frontend.private_ip"
    type = "ssh"
    user = "root"
    password = "${var.PASSWORD}"
    timeout = "30s"
  }
}


output "EC2_Public_IP" {
    value = aws_spot_instance_request.frontend.public_ip
    description = "Publisc IP of WorkStation"
}
output "EC2_instance_id" {
  value       = aws_spot_instance_request.frontend.id
  description = "EC2 Instance ID"
}
resource "aws_route53_record" "frontend" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_spot_instance_request.frontend.public_ip ]
}

