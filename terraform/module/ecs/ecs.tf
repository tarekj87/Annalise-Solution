locals {
  # tags to be assigned to all resources
  tags = {
    Name        = "${var.name}"
    Project     = "${var.name}"
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.cluster_name}"
}

resource "aws_ecs_service" "service" {
  name          = "${var.name}"
  cluster       = "${aws_ecs_cluster.cluster.arn}"
  launch_type   = "FARGATE"
  desired_count = "${var.desired_count}"

  network_configuration {
    security_groups = ["${aws_security_group.ecs_tasks.id}"]
    subnets         = "${var.ecs_subnets.*}"
  }

  task_definition = "${aws_ecs_task_definition.this.arn}"

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 75

  load_balancer {
    target_group_arn = "${aws_alb_target_group.main.arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.containerPort}"
  }

  depends_on = [aws_alb_listener.http, aws_alb_listener.https ]
}

data "aws_region" "current" {}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.name}"
  task_role_arn            = "${aws_iam_role.ecs_task_role.arn}"
  execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "${var.cpu}"
  memory                   = "${var.memory}"
  tags                     = "${local.tags}"
  container_definitions = jsonencode([{
    name        = "${var.container_name}"
    image       = "${var.image_name}:${var.image_tag}"
    essential   = true
    portMappings = [{
      protocol      = "${var.protocol}"
      containerPort = "${var.containerPort}"
      hostPort      = "${var.containerPort}"
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "${aws_cloudwatch_log_group.log_group.name}"
        awslogs-stream-prefix = "ecs"
        awslogs-region        = "${data.aws_region.current.name}"
      }
    }
    
  }])

depends_on = [aws_cloudwatch_log_group.log_group]
}

