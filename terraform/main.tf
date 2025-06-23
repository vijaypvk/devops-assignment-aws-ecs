provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "deployer" {
  key_name   = "vijay-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "app_sg" {
  name        = "simple-app-sg"
  description = "Allow SSH, 3000 (frontend), 8000 (backend)"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "devops_app" {
  ami                         = "ami-0c02fb55956c7d316"  # Ubuntu 22.04 (us-east-1)
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              curl -fsSL https://raw.githubusercontent.com/vijaypvk/BASH/refs/heads/main/updated_docker.sh | bash
              apt install -y git
              git clone https://github.com/vijaypvk/devops-assignment-aws-ecs.git
              cd devops-assignment-aws-ecs
              docker-compose up -d
              EOF

  tags = {
    Name = "DevOps-Fullstack-App"
  }
}
