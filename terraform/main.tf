terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.38.0"
    }
  }
}

provider "aws" {
  region = var.aws-region
}

module "vpc" {
  name               = "my-vpc"
  source             = "./module/vpc"
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  aws-region         = var.aws-region
  
}

module "ecr" {
  source             = "./module/ecr"
}

module "ecs" {
  source             = "./module/ecs"
  vpc_id             =  module.vpc.id
  ecs_subnets        =  module.vpc.private_subnets 
  cluster_name       =  var.cluster_name
  image_name         =  module.ecr.aws_ecr_repository_url
  image_tag          =  var.image_tag
  container_name     =  var.container_name
  hostPort           =  var.hostPort
  containerPort      =  var.containerPort
  protocol           =  var.protocol
  name               =  var.name
  cpu                =  var.cpu
  memory             =  var.memory
  desired_count      =  var.desired_count
  alb_subnets        =  module.vpc.public_subnets
  alb_tls_cert_arn   =  var.alb_tls_cert_arn
}

module "route53" {
  source             = "./module/r53"
  alb_dns            = module.ecs.alb_dns
  zone_id            = var.zone_id
  aws-region         = var.aws-region
  domain_name        = var.domain_name
}
