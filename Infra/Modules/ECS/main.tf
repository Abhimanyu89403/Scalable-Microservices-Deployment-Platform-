resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "${variable.project}-ecs-cluster"
}

data "aws_ami" "linuxami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "my_launch_template" {
  name          = "${variable.project}-launch-template"
  image_id      = data.aws_ami.linuxami.id
  instance_type = "t3.micro"
  network_interfaces {
    security_group              = [data.aws_security_group.ecs_sg.id]
    associate_public_ip_address = true
    delete_on_termination       = false
  }
  key_name = "ansible"
}

resource "aws_autoscaling_group" "my_asg" {
  min_size         = 1
  max_size         = 5
  desired_capacity = 1
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
  health_check_type = true
  health_check_grace_period = 600
  tag {
    key                 = "name"
    value               = "${variable.project}-asg"
    propagate_at_launch = true
  }
}
