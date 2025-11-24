
terraform {
required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 5.0"
}
}
}

provider "aws" {
region = var.aws_region
}


resource "aws_vpc" "app_vpc" {
cidr_block           = var.vpc_cidr_block
enable_dns_hostnames = true

tags = {
Name = "Simple-App-VPC"
}
}


resource "aws_internet_gateway" "app_igw" {
vpc_id = aws_vpc.app_vpc.id

tags = {
Name = "Simple-App-IGW"
}
}


resource "aws_subnet" "app_subnet_public" {
vpc_id                  = aws_vpc.app_vpc.id
cidr_block              = var.subnet_cidr_block
map_public_ip_on_launch = true # This is crucial for "instant" public access
availability_zone       = "${var.aws_region}a"

tags = {
Name = "Simple-App-Public-Subnet"
}
}


resource "aws_route_table" "app_route_table" {
vpc_id = aws_vpc.app_vpc.id

route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.app_igw.id
}

tags = {
Name = "Simple-App-Route-Table"
}
}

resource "aws_route_table_association" "app_rta_public" {
subnet_id      = aws_subnet.app_subnet_public.id
route_table_id = aws_route_table.app_route_table.id
}



resource "aws_security_group" "app_sg" {
name        = "app-instance-security-group"
description = "Allow SSH and HTTP inbound traffic"
vpc_id      = aws_vpc.app_vpc.id


ingress {
description = "Allow SSH from Internet"
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
description = "Allow HTTP from Internet"
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
Name = "App-SG"
}
}


resource "aws_instance" "instant_app_server" {

ami           = var.ami_id
instance_type = var.instance_type
key_name      = var.key_pair_name

subnet_id                   = aws_subnet.app_subnet_public.id
vpc_security_group_ids      = [aws_security_group.app_sg.id]
associate_public_ip_address = true 


user_data = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Hello from Terraform EC2!</h1>" > /var/www/html/index.html
EOF

tags = {
Name = "Instant-Terraform-Server"
}
}