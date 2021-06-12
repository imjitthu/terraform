variable "COMPONENT" {
    default = [
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
    }
variable "AMI" {}
variable "INSTANCE_TYPE" {}
variable "REGION" {}
variable "ENV" {}