resource "aws_instance" "nginx" {
  ami             = data.aws_ami_ids.ubuntu.ids[0]
  instance_type   = "t2.micro"
  subnet_id       = var.nginx_subnet_id
  security_groups = [aws_security_group.allow_http.id]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get -y update
                sudo apt-get -y install nginx
                sudo service nginx start
                EOF

  tags = {
    Name = "nginx"
  }
}

resource "aws_instance" "apache" {
  ami             = data.aws_ami_ids.ubuntu.ids[0]
  instance_type   = "t2.micro"
  subnet_id       = var.apache_subnet_id
  security_groups = [aws_security_group.allow_http.id]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get -y update
                sudo apt-get -y install apache2
                EOF

  tags = {
    Name = "apache"
  }
}