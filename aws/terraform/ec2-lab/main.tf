terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "devops-lab-tfstate-767397688646-v2"
    key    = "ec2-lab/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

# key pair
resource "aws_key_pair" "devops_key" {
  key_name   = "devops-lab-key"
  public_key = file("~/.ssh/deploy_key.pub")
}

# security group
resource "aws_security_group" "devops_sg" {
  name        = "devops-lab-sg"
  description = "Allow SSH, HTTP, and app port"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

# EC2 instance
resource "aws_instance" "devops_lab" {
  ami                    = "ami-05cf1e9f73fbad2e2" # Ubuntu 22.04 us-east-1
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name        = "devops-lab"
    Environment = "learning"
  }
}

# output the public IP
output "instance_ip" {
  value       = aws_instance.devops_lab.public_ip
  description = "EC2 public IP"
}
