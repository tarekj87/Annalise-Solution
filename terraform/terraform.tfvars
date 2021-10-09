cidr                = "10.1.0.0/16"
private_subnets     = ["10.1.70.0/24", "10.1.80.0/24","10.1.90.0/24"]
public_subnets      = ["10.1.40.0/24", "10.1.50.0/24","10.1.60.0/24"]


cluster_name        = "My-Cluster"
image_name          = "nginx"
image_tag           = "latest"
container_name      = "My-Container"
hostPort            = 4567
containerPort       = 4567
protocol            = "tcp"
name                = "annalise"
cpu                 = 256
memory              = 512
desired_count       = 1

alb_tls_cert_arn    = "arn.SomeThing"

zone_id             = "AXZF02DA458GH"
domain_name         = "example.com"