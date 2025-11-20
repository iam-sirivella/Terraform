provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "hari-key-pair-provisioner"
  public_key = file("./hari-key-pair-provisioner.pub")
}

resource "aws_vpc" "samplevpc" {
  cidr_block = var.ipaddress
}

resource "aws_subnet" "subnetsample" {
  vpc_id                  = aws_vpc.samplevpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "samplegateway" {
  vpc_id = aws_vpc.samplevpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.samplevpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.samplegateway.id
  }
}

resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.subnetsample.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
  name   = "web-tag"
  vpc_id = aws_vpc.samplevpc.id

  ingress {
    description = "Flask API"
    from_port   = 5000
    to_port     = 5000
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-tag"
  }
}

resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnetsample.id
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./hari-key-pair-provisioner")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y python3-pip python3-venv",
      "python3 -m venv /home/ubuntu/venv",
      "/home/ubuntu/venv/bin/pip install flask",
      "nohup /home/ubuntu/venv/bin/python /home/ubuntu/app.py > /home/ubuntu/flask.log 2>&1 &"
    ]
  }

  depends_on = [aws_security_group.sg]
}

output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}