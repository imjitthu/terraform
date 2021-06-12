COMPONENT = [
        "mysql",
        "mongodb",
        "redis",
        "rabbitmq",
        "cart",
        "catalogue",
        "shipping",
        "payment",
        "user",
        "frontend"
    ]

INSTANCE_TYPE = "t2.micro"
AMI           = [data.aws_ami.AMI]
REGION        = "us-east-1"
ENV           = "test"