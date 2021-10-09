variable "cluster_name" {}
variable "image_name" {
  type = string
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
variable "name" {
  type = string
}
variable "cpu" {
  type = number
}
variable "memory" {
  type = number
}
variable "desired_count" {
  type = number
}
variable "ecs_subnets" {
  description = "Comma separated list of subnet IDs"
}
variable "vpc_id" {
}

variable "health_check_path" {
  type = string
  default = "/hello-world"
}
variable "alb_subnets" {
  description = "Comma separated list of subnet IDs"
}
variable "alb_tls_cert_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}
