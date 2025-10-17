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











# -----------------------------------------------------2nd version-------------------------------------------------------







#!/bin/bash

set -e

# Update and install prerequisites
sudo apt update
sudo apt install -y curl unzip apt-transport-https gnupg lsb-release software-properties-common

# Install latest Python from deadsnakes PPA (more up-to-date than Ubuntu default)
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.11 python3.11-venv python3.11-distutils
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# Upgrade pip for the installed Python version
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.11

# Install latest AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws/

# Install latest kubectl
OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
  ARCH="amd64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
  ARCH="arm64"
fi

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/${OS}/${ARCH}/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install latest eksctl from official GitHub releases
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo install -m 0755 /tmp/eksctl /usr/local/bin/eksctl
rm /tmp/eksctl

echo "Installation complete: kubectl, eksctl, awscli, python3.11"
