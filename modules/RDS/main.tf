/* The aws_db_instance resource creates the RDS instance with publicly accessible set to true 
and associates it with the specified security group and subnet group.*/

resource "aws_db_instance" "main_RDS" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot
  db_subnet_group_name = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.RDS-SG.id]
}

resource "aws_security_group" "RDS-SG" {
    name        = "${var.env_prefix}-RDS-SG"
  description = "Allow inbound traffic on port 80"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"           # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }
}  
