output "subnet_public_id" {
  value = aws_subnet.subnet_public.id
}

output "subnet_private_id" {
  value = aws_subnet.subnet_private.id
}

output "aws_vpc_id" {
  value = aws_vpc.main.id
}

output "cidr_blocks_public" {
  value = aws_subnet.subnet_public.cidr_block
}