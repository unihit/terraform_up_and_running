resource "aws_security_group" "instance" {
	name = "terraform-example-instance"
	
	ingress {
		from_port		= var.server_port
		to_port			= var.server_port
		protocol		= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "alb" {
	name = "terraform-example-alb"

	# 인바운드 HTTP 트래픽 허용
	ingress {
		from_port   = 80
		to_port	    = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# 모든 아웃바운드 트래픽 허용
	egress {
		from_port		= 0
		to_port			= 0
		protocol		= "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}


