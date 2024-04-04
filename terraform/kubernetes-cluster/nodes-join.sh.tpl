#!/bin/bash
sudo apt-get update -y
sudo apt install awscli -y

MAX_RETRIES=30
RETRY_INTERVAL=10

for ((i=1; i<=$MAX_RETRIES; i++)); do
    value=$(aws ssm get-parameter --name "/cei/k8s/token" --region ${region} --query "Parameter.Value" --output text)
    if [[ -z "$value" ]]; then
        echo "Parameter is empty. Retrying in $RETRY_INTERVAL seconds..."
        sleep $RETRY_INTERVAL
    else
        echo "Parameter is not empty. Proceeding with the script."
        break
    fi
done
curl -sfL https://get.k3s.io | K3S_URL=https://${host}:6443 K3S_TOKEN=$value sh -