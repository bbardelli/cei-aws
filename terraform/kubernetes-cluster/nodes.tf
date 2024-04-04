resource "aws_launch_template" "k8sNodes" {
  name_prefix   = "k8snodes"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  iam_instance_profile {
    name = aws_iam_instance_profile.parameter_store_profile.name
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ingress-test.id]
  }
  user_data = base64encode(templatefile("nodes-join.sh.tpl", { region = data.aws_region.current.name, host = aws_spot_instance_request.control-plane.private_ip }))
}

resource "aws_autoscaling_group" "k8sNodes" {
  name                 = "k8s-nodes"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = data.aws_subnets.default.ids
  termination_policies = ["OldestInstance"]
  lifecycle {
    create_before_destroy = true
  }

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.k8sNodes.id
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