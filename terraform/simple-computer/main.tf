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


#create a simple ec2 instance with user data
resource "aws_spot_instance_request" "simple-computer" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.micro"
  spot_type                   = "one-time"
  associate_public_ip_address = true
  user_data                   = <<-EOFILE
                #!/bin/bash
                sudo yum update -y
                sudo yum install python3 -y
                sudo yum install python3-pip -y
                sudo pip3 install cherrypy
                # Create a Python file
                cat > hello_world.py <<EOF
                import cherrypy

                class HelloWorld:
                    @cherrypy.expose
                    def index(self):
                        return "Hello World!"

                if __name__ == '__main__':
                    cherrypy.config.update({'server.socket_port': 80, 'server.socket_host': '0.0.0.0',})
                    cherrypy.quickstart(HelloWorld())
                EOF
                # Run the server (may need sudo to bind to port 80)
                sudo python3 hello_world.py
              EOFILE
  security_groups             = [aws_security_group.ingress-test.id]
  subnet_id                   = data.aws_subnets.default.ids[0]
  wait_for_fulfillment        = true
  tags = {
    name = "simple-computer"
  }
}