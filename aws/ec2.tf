resource "aws_instance" "app" {
  ami           = "ami-0360c520857e3138f" 
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_1.id
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.web_sg.id]
  tags = { Name = "AWS-App-Instance" }
}

resource "aws_instance" "tools" {
  ami           = "ami-0360c520857e3138f"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_2.id
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.web_sg.id]
  tags = { Name = "AWS-Tools-Instance" }
}

