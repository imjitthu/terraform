resource "aws_instance" "mongo" {
  # aws_spot_instabce_request for spot instance
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  # spot_type = "one-time"  aws_spot_instance_request
  tags = {
    "Name" = "${var.COMPONENT}-Server"
  }
connection {
    type = "ssh"
    host = aws_instance.mongo.public_ip
    user = "root"
    password = "${var.PASSWORD}"
    }

provisioner "file" {
    when = create
    source      = "templates/mongo.repo"
    destination = "/etc/yum.repos.d/mongo.repo"
  }

  provisioner "file" {
    when = create
    source      = "files/"
    destination = "/root/"
  }
provisioner "remote-exec" {
    when = create
    inline = [
      "set-hostname ${var.COMPONENT}",
      "yum install mongodb-org -y",
      "sh files/mongoconf.sh",
      "systemctl daemon-reload",
      "systemctl enable mongod",
      "systemctl restart mongod",      
    ]
}
}

resource "aws_route53_record" "mongo" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.mongo.public_ip ]
}

