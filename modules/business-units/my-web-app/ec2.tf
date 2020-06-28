resource "tls_private_key" "main" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "main" {
  key_name   = "main"
  public_key = tls_private_key.main.public_key_openssh
}

resource "local_file" "ec2_private_key" {
    content     = tls_private_key.main.private_key_pem
    filename = "${path.module}/ec2_private_key.pem"
}

resource "aws_instance" "nginx" {
  ami             = data.aws_ami_ids.ubuntu.ids[0]
  instance_type   = "t2.micro"
  subnet_id       = var.nginx_subnet_id
  security_groups = [aws_security_group.allow_http_ec2.id, aws_security_group.allow_ssh_ec2.id]
  key_name        = aws_key_pair.main.key_name
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
  security_groups = [aws_security_group.allow_http_ec2.id, aws_security_group.allow_ssh_ec2.id]
  key_name        = aws_key_pair.main.key_name
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get -y update
                sudo apt-get -y install apache2
                EOF

  tags = {
    Name = "apache"
  }
}