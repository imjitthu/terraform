variable "REGION" {
    default = "us-east-1"
}

variable "VPC_CIDR" { default = "190.160.0.0/16"}

variable "SUBNET_CIDR" {}

#Manual Availability Zones List
# variable "AV_Zones" {
#     type = "list"
#     default = [
#         "us-east-1a", 
#         "us-east-1b",
#         "us-east-1c",
#         "us-east-1d",
#         "us-east-1e",
#         "us-east-1f", 
#         ]
# }

#Get Availability Zones from DataSources
data "aws_availability_zones" "AV_ZONES" {}

