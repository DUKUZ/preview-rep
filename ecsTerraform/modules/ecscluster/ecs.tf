# Create ECS cluster

locals {
  ecs_cluster_name = var.name
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name               = local.ecs_cluster_name
  capacity_providers = [aws_ecs_capacity_provider.test-tf-ecs-cp.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.test-tf-ecs-cp.name
    base              = 0
    weight            = 1
  }
  depends_on = [aws_ecs_capacity_provider.test-tf-ecs-cp]
}


# Create capacity_provider

resource "aws_ecs_capacity_provider" "test-tf-ecs-cp" {
  name = "${var.name}-ecs_capacity_provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.test-tf-ASG.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100

    }
  }

  depends_on = [aws_autoscaling_group.test-tf-ASG]
}


# Create service

resource "aws_ecs_service" "nginx" {
  name            = var.name
  cluster         = aws_ecs_cluster.ecs_cluster.name
  task_definition = "arn:aws:ecs:us-west-1:618930393314:task-definition/test-tf-TD"
  desired_count   = 1


  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.test-tf-ecs-cp.name
    base              = 0
    weight            = 1
  }
}


# Add AWS Security Group

resource "aws_security_group" "instances" {
  name   = "${var.name}-ECS-instances"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-instances"
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = var.alb_security_group

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
