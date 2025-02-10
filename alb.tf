resource "aws_lb" "tsc_poc_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tsc_poc_lb_sg.id]
  subnets            = [aws_subnet.tsc_poc_public_subnet1.id, aws_subnet.tsc_poc_public_subnet2.id]

  tags = {
    Name       = "application-load-balancer"
    nukeoptout = "true"
  }
}

resource "aws_lb_target_group" "tsc_poc_tg" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tsc_poc_vpc.id

  tags = {
    Name       = "alb-target-group"
    nukeoptout = "true"
  }
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.tsc_poc_tg.arn
  target_id        = aws_instance.tsc_poc_locust_master.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.tsc_poc_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tsc_poc_tg.arn
  }
}
