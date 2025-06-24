provider "aws" {
  region = "us-east-1"
}

# Get latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = "vijay-key"
  public_key = file("C:/Users/vijay/.ssh/id_rsa.pub")  # Replace with your public key path
}

# Security Group
resource "aws_security_group" "app_sg" {
  name        = "simple-app-sg"
  description = "Allow SSH, Frontend (3000), Backend (8000)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In production, replace with your IP
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "devops_app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y docker.io docker-compose git
              systemctl start docker
              systemctl enable docker
              cd /home/ubuntu
              git clone https://github.com/vijaypvk/devops-assignment-aws-ecs.git
              cd devops-assignment-aws-ecs
              docker-compose up -d
              EOF

  tags = {
    Name = "Simple-Fullstack-App"
  }
}
