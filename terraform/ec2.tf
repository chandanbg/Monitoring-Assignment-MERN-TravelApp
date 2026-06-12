# ----------------------------
# Key Pair
# ----------------------------
resource "aws_key_pair" "mern_key" {
  key_name   = "mern-key"
  public_key = file("${path.module}/mern-key.pub")
}

# ----------------------------
# Web Server Security Group
# ----------------------------
resource "aws_security_group" "web_sg" {
  name   = "mern-web-sg"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["106.215.179.210/32"]
  }

  ingress {
    description = "HTTP"
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

# ----------------------------
# DB Security Group
# ----------------------------
resource "aws_security_group" "db_sg" {
  name   = "mern-db-sg"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    description     = "MongoDB from Web SG"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  ingress {
    description     = "SSH from Web SG"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ----------------------------
# Web Server EC2 (Public)
# ----------------------------
resource "aws_instance" "web_server" {
  ami                         = "ami-0bbf725d46f845651"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  key_name                    = aws_key_pair.mern_key.key_name
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "mern-web-server"
  }
}

# ----------------------------
# DB Server EC2 (Private)
# ----------------------------
resource "aws_instance" "db_server" {
  ami                    = "ami-0bbf725d46f845651"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  key_name               = aws_key_pair.mern_key.key_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "mern-db-server"
  }
}
