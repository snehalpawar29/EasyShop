data "aws_ami" "os_image" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/*24.04-amd64*"]
  }
}

resource "aws_key_pair" "easyshop_key" {
  key_name   = "terra-automate-key"
  public_key = file("${path.module}/terra-key.pub")
}


resource "aws_security_group" "easyshop_sg" {
  name        = "easyshop-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.easyshop_sg.id
  cidr_ipv4         = module.vpc.vpc_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.easyshop_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "Port_80" {
  security_group_id = aws_security_group.easyshop_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "Port_8080" {
  security_group_id = aws_security_group.easyshop_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.easyshop_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "easyshop-instance" {
  ami                    = data.aws_ami.os_image.id
  instance_type          = "c7i-flex.large"
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = aws_key_pair.easyshop_key.key_name
  vpc_security_group_ids = [aws_security_group.easyshop_sg.id]
  user_data              = file("${path.module}/install_tools.sh")

  associate_public_ip_address = true
  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  tags = {
    Name        = "easyshop-web-server"
    Environment = "development"
  }
}
