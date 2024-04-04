# Provider configuration for AWS
provider "aws" {
  region = "eu-south-2"
}

data "aws_ecr_authorization_token" "token" {}

# Data source to retrieve the Kubernetes cluster credentials from Parameter Store
data "aws_ssm_parameter" "cluster_host" {
  name = "/cei/k8s/host"
}
data "aws_ssm_parameter" "cluster_ca_certificate" {
  name = "/cei/k8s/client-ca"
}
data "aws_ssm_parameter" "cluster_key" {
  name = "/cei/k8s/client-key"
}
data "aws_ssm_parameter" "cluster_data" {
  name = "/cei/k8s/client-data"
}

# Configure the Kubernetes provider using the retrieved kubeconfig
provider "kubernetes" {
  host                   = data.aws_ssm_parameter.cluster_host.value
  cluster_ca_certificate = base64decode(data.aws_ssm_parameter.cluster_ca_certificate.value)
  client_certificate     = base64decode(data.aws_ssm_parameter.cluster_data.value)
  client_key             = base64decode(data.aws_ssm_parameter.cluster_key.value)
}

provider "helm" {
  kubernetes {
    host                   = data.aws_ssm_parameter.cluster_host.value
    cluster_ca_certificate = base64decode(data.aws_ssm_parameter.cluster_ca_certificate.value)
    client_certificate     = base64decode(data.aws_ssm_parameter.cluster_data.value)
    client_key             = base64decode(data.aws_ssm_parameter.cluster_key.value)
  }
}

resource "kubernetes_secret" "ecr_credentials" {
  metadata {
    name      = "docker-registry"
    namespace = "default"
  }
  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${data.aws_ecr_authorization_token.token.proxy_endpoint}" = {
          auth = "${data.aws_ecr_authorization_token.token.authorization_token}"
        }
      }
    })
  }


}