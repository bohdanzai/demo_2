resource "aws_alb" "main" {
  name            = "${var.app_name}-${var.environment}-lb"
  subnets         = [for subnet in var.subnet_pub_id : subnet.id]
  security_groups = [var.alb_security_group_ids.id]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.app_name}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    healthy_threshold   = "2"
    interval            = "15"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}
