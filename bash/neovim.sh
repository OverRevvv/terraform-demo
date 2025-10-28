#!/bin/bash
set -e 

sudo add-apt-repository ppa:neovim-ppa/unstable -y  # for latest development version
sudo apt update
sudo apt install neovim

# lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# requerments
sudo apt install gcc -y
sudo apt install node -y