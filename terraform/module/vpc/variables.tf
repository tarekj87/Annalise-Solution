variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of public subnets"
}

variable "aws-region" {
  description = "AWS Region"
}
