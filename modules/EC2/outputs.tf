output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
}

output "server_SG_id" {
  value = aws_security_group.server-SG.id
}

output "key_name_id" {
  value = aws_key_pair.main_key_pair.key_name
}
