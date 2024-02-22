/* The aws_lb resource creates the Application Load Balancer.
The aws_lb_target_group resource creates a target group for the ALB.
The aws_lb_listener resource defines a listener for the ALB.
The aws_launch_configuration resource creates the launch configuration for the Auto Scaling Group.
The aws_autoscaling_group resource creates the Auto Scaling Group.*/

resource "aws_launch_configuration" "main_lc" {
  name = "${var.env_prefix}-lc"
  
  image_id        = var.image_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [var.security_groups]
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = [var.vpc_zone_identifier]
  launch_configuration = aws_launch_configuration.main_lc.id
}

resource "aws_lb" "main_alb" {
  name               = "${var.env_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_SG.id]
  subnets            = [var.subnets]
  enable_deletion_protection = true

  tags = {
    Environment = "var.env_prefix"
  }
}

resource "aws_security_group" "ALB_SG" {
  name        = "${var.env_prefix}-alb-SG"
  vpc_id      = var.vpc_id  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any source to port 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic to any destination
  }
}

resource "aws_lb_target_group" "main_target_group" {
  name     = "${var.env_prefix}-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path     = "/"
    protocol = "HTTP"
    port     = 80
  }
}

resource "aws_lb_listener" "main_listener" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "main_target_attachment" {
  target_group_arn = aws_lb_target_group.main_target_group.arn
  target_id        = aws_autoscaling_group.main_asg.id
}
