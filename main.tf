module "VPC" {
  source                    = "./modules/VPC"
  vpc_cidr_block            = var.vpc_cidr_block
  subnet_public_cidr_block  = var.subnet_public_cidr_block
  subnet_private_cidr_block = var.subnet_private_cidr_block
  AZ_subnet_public          = var.AZ_subnet_public
  AZ_subnet_private         = var.AZ_subnet_private
  env_prefix                = var.env_prefix
}

module "EC2" {
  source                    = "./modules/EC2"
  instance_type             = var.instance_type
  public_key_location       = var.public_key_location
  subnet_id                 = module.VPC.subnet_public_id
  env_prefix                = var.env_prefix
}

module "ALB" {
  source                    = "./modules/ALB"
  image_id                  = module.EC2.aws_ami_id
  instance_type             = var.instance_type
  key_name                  = module.EC2.key_name_id
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = module.VPC.subnet_public_id
  subnets                   = module.VPC.subnet_public_id
  security_groups           = module.EC2.server_SG_id
  vpc_id                    = module.VPC.aws_vpc_id
  env_prefix                = var.env_prefix
}

module "RDS" {
  source = "./modules/RDS"
  allocated_storage         = var.allocated_storage
  db_name                   = var.db_name
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  username                  = var.username
  password                  = var.password
  parameter_group_name      = var.parameter_group_name
  skip_final_snapshot       = var.skip_final_snapshot
  db_subnet_group_name      = module.VPC.subnet_private_id
  cidr_blocks               = module.VPC.cidr_blocks_public
  env_prefix                = var.env_prefix
}