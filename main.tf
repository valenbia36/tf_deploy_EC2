terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  required_version = ">=1.4.0"
}

provider "aws" {
  region = "var.region"
}
resource "aws_security_group" "ssh_http" {
    name = "sg_vb"
    description = "Allow SSH and HTTP"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
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
    ami = data.aws_ami.amazon_linux2.id
    instance_type = "t2.micro"
    security_groups = [aws_security_group.ssh_http.name]
    tags = {
        name = "EC2 instance by VB"
    }
}
