resource "aws_load_balancer" "alb_listner" {
    name = "${variable.project}-alb-listner"
    internal = false
    load_balancer_type = "application"
    security_groups = [data.aws_security_group.alb_sb.id]
    subnets = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
    port = 80
    protocol = "HTTP"
}

resource "aws_lb_tg" "tg" {
    name = "${variable.project}-tg"
    port = 3000
    protocol = "HTTP"
    vpc_id = data.aws_vpc.my_vpc.id
    health_check {
        path = "/health"
    }
}

resource "aws_lb_listner" "alb_listner" {
    load_balancer_arn = aws-load_balancer.alb_listner.arn
    port = 80
    protocol = "HTTP"
    default_actions {
        type = "forward"
        tagert_group_arn = aws_lb_tg.tg.arn
    }
}