#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl apt-transport-https ca-certificates software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# sudo apt install neovim -y
sudo apt install docker-compose -y
# sudo systemctl status docker
# sudo apt install gcc -y
# git clone https://github.com/LazyVim/starter ~/.config/nvim
# rm -rf ~/.config/nvim/.git
sudo docker --version
sudo usermod -aG docker $USER
# nvim --version
# docker container run -itd -p 8080:8080 -v jenkins:/var/jenkins_home jenkins/jenkins:lts

sudo add-apt-repository ppa:neovim-ppa/unstable -y  # for latest development version
sudo apt update
sudo apt install neovim

# 1. Update package lists
sudo apt update

# 2. Install dependencies
sudo apt install -y gnupg software-properties-common

# 3. Add HashiCorp’s GPG key
wget -qO- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/hashicorp-archive-keyring.gpg

# 4. Add the HashiCorp repository
echo "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# 5. Update again for the new repo
sudo apt update

# 6. Install Terraform
sudo apt install terraform

# 7. Verify installation
terraform -version


# sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible
ansible --version

sudo apt install snap -y
sudo snap install kubectl --classic
kubectl version --client
