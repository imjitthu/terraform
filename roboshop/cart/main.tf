resource "aws_instance" "cart" {
  # aws_spot_instabce_request for spot instance
  ami = "${var.AMI}"
  instance_type = "${var.INSTANCE_TYPE}"
  # spot_type = "one-time"  aws_spot_instance_request
  tags = {
    "Name" = "${var.COMPONENT}-Server"
  }
connection {
    type = "ssh"
    host = aws_instance.cart.public_ip
    user = "root"
    password = "${var.PASSWORD}"
    }

provisioner "file" {
    when = create
    source      = "files/"
    destination = "/home/roboshop/${var.COMPONENT}"
  }

provisioner "remote-exec" {
    when = create
    inline = [
      "set-hostname ${var.COMPONENT}",
      "mkdir -p /home/roboshop/${var.COMPONENT}",
      "cd /home/roboshop/${var.COMPONENT}",
      "npm install --unsafe-perm",
    ]
}

provisioner "file" {
    when = create
    source      = "templates/cart.service"
    destination = "/home/roboshop/${var.COMPONENT}/cart.service"
  }


provisioner "remote-exec" {
    when = create
    inline = [
      "systemctl daemon-reload",
      "systemctl enable ${var.COMPONENT}",
      "systemctl restart ${var.COMPONENT}",
    ]
}

resource "aws_route53_record" "cart" {
  zone_id = "${var.R53_ZONE_ID}"
  name = "${var.COMPONENT}.${var.DOMAIN}"
  type = "A"
  ttl = "300"
  records = [ aws_instance.cart.public_ip ]
}

