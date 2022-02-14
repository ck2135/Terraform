resource "aws_lb_target_group" "test-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "tf-example-lb-tg"  
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "${aws_vpc.default.id}"
}


resource "aws_lb" "test-lb" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  ip_address_type            = "ipv4"
  security_groups            = ["${aws_security_group.allow_all.id}"]
  subnets                    = "${aws_subnet.public.*.id}"
  enable_deletion_protection = false 

#  access_logs {
#    bucket  = aws_s3_bucket.lb_logs.bucket
#    prefix  = "test-lb"
#    enabled = true
#  }

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "test-listener" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.test-tg.arn}"
  }
}


resource "aws_lb_target_group_attachment" "test-attach" {
  count = length(aws_instance.webservers)
  target_group_arn = aws_lb_target_group.test-tg.arn
  target_id        = aws_instance.webservers[count.index].id
  #port             = 80
}

output "elb-dns-name" {
  value = "${aws_lb.test-lb.dns_name}"
}