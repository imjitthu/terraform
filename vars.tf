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
variable "AMI" {default = ""}
variable "INSTANCE_TYPE" {default = ""}
variable "REGION" {default = ""}
variable "ENV" {default = ""}