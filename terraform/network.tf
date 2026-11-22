resource "aws_security_group" "app" {
  name        = "${var.project_name}-sg"
  description = "Acesso publico a aplicacao"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP Application"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}
