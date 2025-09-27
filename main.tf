terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">=1.4.0"
}
provider "aws" {
  region = var.region_EC2
}
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ssh_http" {
  name        = "sg_vb"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id  

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "vb_ec2" {
  ami                    = "ami-005efd5afe550784a"  
  instance_type           = "t3.micro"              
  vpc_security_group_ids  = [aws_security_group.ssh_http.id] 
  tags = {
    Name = "EC2 instance by VB"
  }
}
