resource "aws_lb" "external" {
  name               = "${var.project_name}-external-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.web_tier_sg_id, var.external_alb_sg_id]

  tags = {
    Name    = "${var.project_name}-external-alb"
    Project = var.project_name
  }
}

resource "aws_lb_target_group" "web-tg" {
  name     = "${var.project_name}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name    = "${var.project_name}-web-tg"
    Project = var.project_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.external.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-tg.arn
  }
}


resource "aws_launch_template" "web-lt" {
  name_prefix   = "${var.project_name}-web-lt"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = var.web_instance_type
  user_data     = base64encode(templatefile("${path.module}/web.sh", {}))
  vpc_security_group_ids = [var.web_tier_sg_id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "${var.project_name}-web-instance"
      Project = var.project_name
    }
  }

  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }
}

resource "aws_autoscaling_group" "web-asg" {
  name                      = "${var.project_name}-web-asg"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.public_subnet_ids
  target_group_arns         = [aws_lb_target_group.web-tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300
  launch_template {
    id      = aws_launch_template.web-lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-web-instance"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}


