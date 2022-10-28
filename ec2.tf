data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "my_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "lab-gustavo"
  subnet_id                   = aws_subnet.my_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.permitir_ssh_http.id]
  associate_public_ip_address = true
  user_data_replace_on_change = true
  user_data                   = file("templates/bootstrap.sh")

  tags = {
    Name = "server01"
  }

}


resource "aws_security_group" "permitir_ssh_http" {
  name        = "permitir_ssh"
  description = "Permite SSH e HTTP na instancia EC2"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
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

  tags = {
    Name = "permitir_ssh_e_http"
  }
}

output "public_ip_address" {
  description = "EC2 public IP address"
  value       = aws_instance.my_ec2.public_ip
}

output "ssh_key_filename" {
  description = "SSH key filename"
  value       = "${aws_instance.my_ec2.key_name}.pem"
}