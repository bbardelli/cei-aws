locals {
  azs = data.aws_availability_zones.available.names
}

data "aws_availability_zones" "available" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = [local.azs[0]]
  }
}

resource "aws_security_group" "ingress-test" {
  name   = "allow-ingress-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 80
    to_port   = 80
    protocol  = "tcp"
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 443
    to_port   = 443
    protocol  = "tcp"
  }

  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]

    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}