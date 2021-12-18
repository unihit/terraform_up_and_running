resource "aws_launch_configuration" "example" {
	image_id			  = "ami-0ed11f3863410c386"
	instance_type   = "t2.micro"
	security_groups = [aws_security_group.instance.id]
	
	user_data = <<-EOF
								#! /bin/bash
								echo "Hello, World" > index.html
								nohup busybox httpd -f -p ${var.server_port} &
								EOF

	# ASG에서 시작 구성을 사용할 때 필요합니다.
	lifecycle {
		create_before_destroy = true
	}
}

resource "aws_autoscaling_group" "example" {
	launch_configuration = aws_launch_configuration.example.name
	vpc_zone_identifier  = data.aws_subnet_ids.default.ids

	target_group_arns = [aws_lb_target_group.asg.arn]
	health_check_type = "ELB"

	min_size = 2
	max_size = 10

	tag {
		key									= "Name"
		value								= "terraform-asg-example"
		propagate_at_launch = true
	}
}

