SUBNET_CIDR = [ 
    "190.160.1.0/24",
    "190.160.2.0/24",
    "190.160.3.0/24",
    "190.160.4.0/24",
    "190.160.5.0/24",
    "190.160.6.0/24",
]

#Get Availability Zones from DataSources
data "aws_availability_zones" "AV_ZONES" {}