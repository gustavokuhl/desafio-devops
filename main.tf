terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = var.aws.profile
  region  = var.aws.region
}

resource "aws_vpc" "vpc_lab_gustavo" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_lab_gustavo"
  }
}

resource "aws_route_table" "route_table_lab_gustavo" {
  vpc_id = aws_vpc.vpc_lab_gustavo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_lab_gustavo.id
  }

  tags = {
    Name = "route_table_lab_gustavo"
  }
}

resource "aws_route_table_association" "route_table_association_lab_gustavo" {
  subnet_id      = aws_subnet.subnet_lab_gustavo.id
  route_table_id = aws_route_table.route_table_lab_gustavo.id
}

resource "aws_internet_gateway" "internet_gateway_lab_gustavo" {
  vpc_id = aws_vpc.vpc_lab_gustavo.id

  tags = {
    Name = "internet_gateway_lab_gustavo"
  }
}

resource "aws_subnet" "subnet_lab_gustavo" {
  vpc_id            = aws_vpc.vpc_lab_gustavo.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subnet_lab_gustavo"
  }
}

resource "aws_security_group" "allow-http-lab-gustavo" {
  name        = "allow-http-lab-gustavo"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.vpc_lab_gustavo.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
  }

  tags = {
    Name = "allow_http_cnx"
  }
}

resource "aws_instance" "ec2-lab-gustavo" {
  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_lab_gustavo.id
  vpc_security_group_ids = [aws_security_group.allow-http-lab-gustavo.id]
  private_ip             = "10.0.0.10"
  key_name = "lab-gustavo"

  tags = {
    Name = "ec2-lab-gustavo"
  }
}

resource "aws_eip" "eip-lab-gustavo" {
  instance = aws_instance.ec2-lab-gustavo.id
  vpc      = true
}

output "public_ip_address" {
  description = "The public IP address"
  value       = aws_eip.eip-lab-gustavo.public_ip
}