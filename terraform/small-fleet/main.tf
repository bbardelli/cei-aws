provider "aws" {
  region = "eu-south-2"
}

#get latest ami id for amazon linux 2023
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"] # This is typically the owner ID for Amazon-owned AMIs

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"] # Adjust this pattern for Amazon Linux 2023 once available
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}