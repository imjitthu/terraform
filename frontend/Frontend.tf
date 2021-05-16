resource "aws_instance" "frontend" {
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  #spot_type = "one-time"  aws_spot_instance_request
  tags = {
    "Name" = "${var.COMPONENT}-Web-Server"
  }
connection {
    type = "ssh"
    host = aws_instance.frontend.public_ip
    user = "root"
    password = "${var.PASSWORD}"
    }
  # connection {
  #   host = self.private_ip
  # }
provisioner "remote-exec" {
    when = create
    inline = [
      "set-hostname frontend",
      "yum install nginx -y",
    ]
}
provisioner "file" {
    when = create
    source      = "files/"
    destination = "/usr/share/nginx/html/"
  }
provisioner "file" {
    source      = "templates/roboshop.conf"
    destination = "/etc/nginx/default.d/roboshop.conf"
  }

provisioner "file" {
  source        = "templates/nginx.conf"
  destination   = "/etc/nginx/nginx.conf"
}
provisioner "remote-exec" {
    when = create
    inline = [
      "systemctl enable nginx",
      "systemctl restart nginx",
    ]
}
provisioner "local-exec" {
   command = "echo ${self.public_ip} > public_ip.txt"
}
  depends_on = [ aws_instance.frontend ]
}


output "EC2_Public_IP" {
    value = aws_instance.frontend.public_ip
    description = "Publisc IP of WorkStation"
}
output "EC2_instance_id" {
  value       = aws_instance.frontend.id
  description = "EC2 Instance ID"
}
resource "aws_route53_record" "frontend" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.frontend.public_ip ]
}

