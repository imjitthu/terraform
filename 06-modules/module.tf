module "module1" {
  source          = "./module1"
  INSTANCE_TYPE   = "t2.micro"
}

module "module2" {
  depends_on = [module.module1]
  source = "./module2"
  PUBLIC_IP = module.module1.PUBLIC_IP
}

provider "aws" {
  region = "us-east-1"
}

output "PUBLIC_IP" {
  value = module.module1.PUBLIC_IP
}