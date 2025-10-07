#!/bin/bash

set -e

# Update and install prerequisites
sudo apt update
sudo apt install -y curl unzip apt-transport-https gnupg lsb-release software-properties-common

# Install latest Python
sudo apt install -y python3 python3-pip python3-venv
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install latest AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

# Install latest kubectl
curl -fsSLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install latest eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
sudo chmod +x /usr/local/bin/eksctl

echo "Installation complete: kubectl, eksctl, awscli, python3"
