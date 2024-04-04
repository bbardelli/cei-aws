#create a simple ec2 instance with user data
resource "aws_iam_instance_profile" "parameter_store_profile" {
  name = "paramter_store_profile"
  role = aws_iam_role.parameter_store_role.name
}
resource "aws_spot_instance_request" "control-plane" {
  ami                         = data.aws_ami.ubuntu.id
  iam_instance_profile        = aws_iam_instance_profile.parameter_store_profile.name
  instance_type               = "t3.medium"
  spot_type                   = "one-time"
  associate_public_ip_address = true
  user_data                   = <<-EOFILE
                                #!/bin/bash
                                sudo apt-get update -y
                                sudo apt install awscli -y
                                curl -sfL https://get.k3s.io | sh -s - --tls-san $(ec2metadata --public-ipv4)
                                JOIN_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
                                CLIENT_DATA=$(sudo kubectl config view --flatten --output='jsonpath={.users[*].user.client-certificate-data}')
                                CLIENT_KEY=$(sudo kubectl config view --flatten --output='jsonpath={.users[*].user.client-key-data}')
                                CLIENT_CA=$(sudo kubectl config view --flatten --output='jsonpath={.clusters[*].cluster.certificate-authority-data}')
                                aws ssm put-parameter --name "/cei/k8s/token" --value $JOIN_TOKEN --type String --region ${data.aws_region.current.name}
                                aws ssm put-parameter --name "/cei/k8s/client-data" --value $CLIENT_DATA --type String --region ${data.aws_region.current.name}
                                aws ssm put-parameter --name "/cei/k8s/client-key" --value $CLIENT_KEY --type String --region ${data.aws_region.current.name}
                                aws ssm put-parameter --name "/cei/k8s/client-ca" --value $CLIENT_CA --type String --region ${data.aws_region.current.name}
                                EOFILE
  security_groups             = [aws_security_group.ingress-test.id]
  subnet_id                   = data.aws_subnets.default.ids[0]
  wait_for_fulfillment        = true
  tags = {
    Name = "Control Plane"
  }
}

resource "aws_ssm_parameter" "k8s_host" {
  name  = "/cei/k8s/host"
  type  = "String"
  value = "https://${aws_spot_instance_request.control-plane.public_ip}:6443"
}