
resource "aws_launch_template" "example" {
  name_prefix   = "example"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ingress-test.id]
  }
  user_data = filebase64("user-data.sh")
}

resource "aws_autoscaling_group" "example" {
  name                 = "example"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = data.aws_subnets.default.ids
  termination_policies = ["OldestInstance"]
  target_group_arns    = [aws_lb_target_group.example.arn]
  lifecycle {
    create_before_destroy = true
  }

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.example.id
        version            = "$Latest"
      }
    }

    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 0
      spot_allocation_strategy                 = "lowest-price"
      spot_instance_pools                      = 1
    }
  }
}
