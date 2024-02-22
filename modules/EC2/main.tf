data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "server-public" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type
  subnet_id = var.subnet_id  
  vpc_security_group_ids = [aws_security_group.server-SG.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.main_key_pair.key_name
  tags = {
    Name = "${var.env_prefix}-server-public"

  }
}
resource "aws_security_group" "server-SG" {
  name        = "${var.env_prefix}-server-SG"
  description = "Allow inbound traffic on port 80"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22  # Allow SSH for demonstration purposes
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "main_key_pair" {
  key_name   = "server-key"
  public_key = file(var.public_key_location)
  
  tags = {
    Name = "${var.env_prefix}-key-pair"
  }
}  
