variable "CIDR_LIST" {
    default = ""
    description = "list variable for CIDRs"
}

variable "CIDR_MAP" {
    default = {
        vpc_1 = "10.0.0.0/16",
        vpc_2 =  "10.2.0.0/16",
    }
    description = "Map variable for CIDRs"
}