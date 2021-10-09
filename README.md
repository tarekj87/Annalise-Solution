# Annalise-Solution

## Solution Overview

In this solution I am going to deploy Ruby application (Hello-World) to AWS. I am using Terraform as IAC to provition all the resources needed and ECS with FARGATE to depoy and scale the app. This solution consider the high availibility by using ECS behind the LaodBalancer.

## Solution Pre-requisite

  1. AWS Account
  2. AWS IAM User with needed IAM plicies to provition all the infrastructes, resources and IAM roles defined in the CloudForamtion templates.
  3. IAM user's Access Key and Secret Access Key.
  4. Create github secrets with name AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY.
  5. AWS Route53 domain name and replace domain_name and zone_id values in [terraform.tfvars](terraform/terraform.tfvars)
  6. AWS valid certificate and replace alb_tls_cert_arn value in [terraform.tfvars](terraform/terraform.tfvars)

## About the application

The [application](app) is a single page to print hello-world. I am using Ruby on Rails with Sinatara as Web Framwork. 

## CI/CD and Automation

I am using github workflow defined in [pipeline file](.github/workflows/pipeline.yaml) to automate the build and push process of the docker container to AWS ECR and then automate the deployment to ECS cluster. The docker container is defined by the [file](Dockerfile) which is going to run our Ruby web application.
The workflow also is provisioning  the resources defined in Terraform modules.

## About Terraform Modules:

I am using Terraform version v0.15.4
  1. [First Module](terraform/module/vpc) is to provision the VPC, Subnets, Route Tables, Nat Gateway and all the network resources needed for this solution (It's Terraform registry module). You have an option to customize the subnets and nat gw by replacing the values defined in [terraform.tfvars](terraform/terraform.tfvars)
  2. [Second Module](terraform/module/ecr) is going to provison ECR repository.
  3. [Third Module](terraform/module/ecs) is going to create the ECS cluster with a task definitions, a service, application load balancer and all the resources needed for ECS and ALB.
  4. [Forth Module](terraform/module/r53) is going to register ECS's load balancer as an alias in Route53 Domain.

## Loging and Monitoring

The ECS is sending the web app logs to AWS cloudwatch log group defined by the name "annalise".

## How to access the app

Once you deply, you access the app by using (https://your_domain_name/hello-world). Replace "your_domain_name" with your actual domain name.

## I would do to run the app in production:

In a production environment I would do the following:

  1. AWS CloudFront as CDN for caching (The origin is pointing to ALB)
  2. AWS WAF as firewall for CloudFront.
  3. Upload the app assets to S3 with cloudfront ( in case the app had assets).
  4. Use Terraform remote state backend (S3).
  5. Use Terraform state lock (DynamoDB).

## Answers for the questions in Part 2 of the assesment

  1. To provide the operation staff SSH access to EC2 instance you might use SSM session manger, bastion host or AWS SSM run command ( in case you know the command they might run).
  2. The application logs are send out to CloudWatch under log group name "annalise".