variable "aws-region" {
  description = "AWS Region you need to deploy to"
}

variable "name" {
  description = "the name of your stack"
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

variable "cluster_name" {
}

variable "image_tag" {
  type = string
  default = "latest"
}
variable "container_name" {
  type = string
}
variable "hostPort" {
  type = number
}
variable "containerPort" {
  type = number
}
variable "protocol" {
  type = string
}

variable "cpu" {
  type = number
}
variable "memory" {
  
}
variable "desired_count" {
  type = number
}
variable "health_check_path" {
  type = string
  default = "/hello-world"
}

variable "alb_tls_cert_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}
variable "zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}
