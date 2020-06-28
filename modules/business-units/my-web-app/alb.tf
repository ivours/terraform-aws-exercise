resource "aws_lb" "main" {
  name               = "main"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_alb.id]
  subnets            = var.public_subnets_ids
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_target_group" "main" {
  name     = "main"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "nginx" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.nginx.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "apache" {
  target_group_arn = aws_lb_target_group.main.arn
  target_id        = aws_instance.apache.id
  port             = 80
}