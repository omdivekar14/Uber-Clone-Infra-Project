########################################################
# Fetch Amazon Linux 2 AMI
########################################################
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

########################################################
# Variables for ASG
########################################################
variable "instance_type" {
  description = "Instance type for app servers"
  type        = string
  default     = "t3.micro"
}

variable "asg_desired_capacity" {
  description = "ASG desired node count"
  type        = number
  default     = 2
}

variable "asg_min_size" {
  description = "Minimum nodes"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum nodes"
  type        = number
  default     = 3
}

########################################################
# Launch Template
########################################################
resource "aws_launch_template" "web_lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [var.app_sg_id]
  }

  # IMPORTANT — pass rendered user_data
  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-web"
    }
  }
}

########################################################
# Auto Scaling Group
########################################################
resource "aws_autoscaling_group" "web_asg" {
  name                = "${var.project_name}-asg"
  desired_capacity    = var.asg_desired_capacity
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  # Attach to ALB target group
  target_group_arns = [var.alb_tg_arn]

  health_check_type            = "ELB"
  health_check_grace_period    = 120

  ####################################################
  # INSTANCE REFRESH — THIS FIXES USER_DATA UPDATES
  ####################################################
  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-web"
    propagate_at_launch = true
  }

  ####################################################
  # Prevent destroy-before-create
  ####################################################
  lifecycle {
    create_before_destroy = true
  }
}
