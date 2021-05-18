resource "aws_instance" "redis" {
  # aws_spot_instabce_request for spot instance
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  # spot_type = "one-time"  aws_spot_instance_request
  tags = {
    "Name" = "${var.COMPONENT}-Server"
  }
connection {
    type = "ssh"
    host = aws_instance.redis.public_ip
    user = "root"
    password = "${var.PASSWORD}"
    }

provisioner "remote-exec" {
    when = create
    inline = [
      "set-hostname ${var.COMPONENT}",
      "yum install epel-release yum-utils -y",
      "yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y",
      "yum-config-manager --enable remi",
      "yum install redis -y",
      "sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf",
    ]
}


provisioner "remote-exec" {
    when = create
    inline = [
      "systemctl daemon-reload",
      "systemctl enable ${var.COMPONENT}",
      "systemctl restart ${var.COMPONENT}",
    ]
}
}

resource "aws_route53_record" "redis" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.redis.public_ip ]
}