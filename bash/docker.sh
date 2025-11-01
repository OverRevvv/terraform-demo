#!/bin/bash

# Exit on error
set -e

# Update package list and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install required dependencies
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's official repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list with Docker repo
sudo apt update

# Install Docker Engine and CLI
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Optional: Allow current user to run Docker commands without sudo (will require re-login)
sudo usermod -aG docker $USER

# Output Docker version to verify installation
docker --version
