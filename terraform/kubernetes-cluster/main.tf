data "aws_region" "current" {}
provider "aws" {
  region = "eu-south-2"
}

#get latest ami id for amazon linux 2023
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"] # This is typically the owner ID for Amazon-owned AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-2024*"] # Adjust this pattern for Amazon Linux 2023 once available
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}