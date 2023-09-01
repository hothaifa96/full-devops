provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_subnet" "public-subnet1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block              = "10.0.0.0/24" 
  availability_zone       = "us-east-1a" 
  map_public_ip_on_launch = true
}
resource "aws_vpc" "vpc1" {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support = true
  enable_dns_hostnames = true
}


resource "aws_security_group" "sg-ter-1" {
    vpc_id = aws_vpc.vpc1.id

    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    ingress {
        description    = "allow ssh from vpc"
        from_port      = 22
        to_port        = 22
        protocol       = "tcp"
        cidr_blocks    = [aws_vpc.vpc1.cidr_block]
  }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
    

}

resource "aws_instance" "flask_app" {
    ami               = "ami-08bf0e5db5b302e19"
    instance_type     = "t2.micro"
    subnet_id = aws_subnet.public-subnet1.id
    security_groups = [aws_security_group.sg-ter-1.id]
    user_data = <<EOF
                #!/bin/bash
                echo "install docker"
                sudo apt update
                sudo apt isntall docker -y
                sudo apt-get install ca-certificates curl gnupg
                sudo install -m 0755 -d /etc/apt/keyrings
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                sudo chmod a+r /etc/apt/keyrings/docker.gpg
                echo \
                  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                sudo apt-get update
                sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
                echo "docker installed"
                echo "run image"
                sudo docker run -p 80:5000 -d 514080426196.dkr.ecr.us-east-1.amazonaws.com/demo1:latest
    EOF
}

output "flask_app"{
    value = aws_instance.flask_app.public_ip
}
output "flask_app_private"{
    value = aws_instance.flask_app.private_ip
}
