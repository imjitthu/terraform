resource "aws_instance" "mysql" {
  # aws_spot_instabce_request for spot instance
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  # spot_type = "one-time"  aws_spot_instance_request
  tags = {
    "Name" = "${var.COMPONENT}-Server"
  }
connection {
    type = "ssh"
    host = aws_instance.mysql.private_ip
    user = "root"
    password = "${var.PASSWORD}"
    }

provisioner "file" {
    source = "files/mysql.repo"
    destination = "/etc/yum.repos.d/mysql.repo"
}

provisioner "file" {
    source = "files/"
    destination = "/tmp/"
}
provisioner "remote-exec" {
    inline = [
      "set-hostnamme mysql",
      "yum remove mariadb-libs -y",
      "yum install mysql-community-server -y",
      "systemctl enable mysqld",
      "systemctl start mysqld",
      "sh /tmp/resetpass.sh"
    ]
}

}

resource "aws_route53_record" "mysql" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.mysql.private_ip ]
}

output "mysql_server_public_ip" {
  value = aws_instance.mysql.public_ip
}


