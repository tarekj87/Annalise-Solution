# Use Terraform Registiry VPC Module ( Autorized Module )

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  
  name = "My-VPC"
  cidr = "${var.cidr}"

  

  azs             =  ["${var.aws-region}a", "${var.aws-region}b", "${var.aws-region}c"]
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
  }
}