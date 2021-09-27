# Create the Auto Scaling resources:

# Add Launch template

resource "aws_launch_template" "ECS-tf-LT" {
  name                   = var.name
  image_id               = var.ECS_instance_ami
  instance_type          = var.ECS_instance_type
  user_data              = base64encode(templatefile("${path.module}/templates/user_data.sh", { ecs_cluster_name = local.ecs_cluster_name }))
  vpc_security_group_ids = [aws_security_group.instances.id]
  key_name               = var.ecs_instance_keyname
  #subnet_id              = var.subnet_private_id


  instance_market_options {
    market_type = "spot"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ECS_instance_profile.arn
  }

}


# Add autoscaling group

resource "aws_autoscaling_group" "test-tf-ASG" {
  name = var.name
  #availability_zones    = ["us-west-1b"]
  desired_capacity      = 0
  max_size              = 20
  min_size              = 0
  protect_from_scale_in = true
  vpc_zone_identifier   = [var.subnet_private_id]
  depends_on            = [aws_launch_template.ECS-tf-LT]

  launch_template {
    id      = aws_launch_template.ECS-tf-LT.id
    version = "$Latest"

  }
}
