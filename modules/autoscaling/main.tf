resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix = "webserver-launch-config"
  #image_id = "ami-0fb653ca2d3203ac1"
  image_id        = var.os_image
  instance_type   = "t2.micro"
  security_groups = [var.vpc_security_group_ids.id]
  lifecycle {
    create_before_destroy = true
  }
  # user_data = file("./modules/autoscaling/start.sh")
  user_data = <<-EOF
    #! /bin/bash
    sudo apt update
    sudo apt -y install apache2
    sudo echo "<h1>WORKS</h1>" > /var/www/html/index.html
    ip address | grep "inet 10" | awk '{print $2}' >> /var/www/html/index.html
    sleep 1
    sudo service apache2 start
    sudo chkconfig apache2 on
    EOF

}

resource "aws_autoscaling_group" "Demo-ASG-tf" {
  name = "Demo2-ASG"
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2
  force_delete         = true
  target_group_arns    = ["${var.alb_target.arn}"]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier  = [for subnet in var.subnet_priv_id : subnet.id]

  tag {
    key                 = "Name"
    value               = "Demo2-ASG"
    propagate_at_launch = true
  }
}
