#!/bin/bash

# temp="USER INPUT"
read -p "Will install Neovim for the current user, press <ENTER> to continue..."

read -p "Is this a WSL installation? (y/n)? " WSL

set -x
NVIM_FILE=nvim.appimage
NVIM_PATH=~/appimages/

mkdir -p $NVIM_PATH
# curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $NVIM_PATH$NVIM_FILE
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o $NVIM_PATH$NVIM_FILE
chmod +x $NVIM_PATH$NVIM_FILE
sudo ln -s $NVIM_PATH$NVIM_FILE /usr/bin/nvim

# Get config dir
cd ~
git clone https://github.com/mangelozzi/.config.git ~/.config

# Get my plugins
mkdir -p ~/.config/nvim/tmp/
cd ~/.config/nvim/tmp/
git clone https://github.com/mangelozzi/vim-capesky.git
git clone https://github.com/mangelozzi/nvim-rgflow.lua.git
# git clone https://github.com/mangelozzi/vim-wsl.git

echo "alias vim=nvim" >> ~/.bashrc

case ${WSL:0:1} in
    n|N )
        sudo apt install xclip
    ;;
    y|Y )
        # Clipboard
        curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
        unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
        chmod +x /tmp/win32yank.exe
        sudo mv /tmp/win32yank.exe /usr/local/bin/win32yank.exe
    ;;
esac

# Install python support
sudo apt install -y python3-pip
pip3 install pynvim

sudo apt install -y curl
# NPM
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs
echo -e "\n\nTesting Node installation version"
node -v
npm -v
echo -e "\n\n"
# LSP: python
sudo npm install -g pyright
# LSP: JSON, CSS, HTML
sudo npm install -g vscode-langservers-extracted
# LSP: Javascript
sudo npm install -g typescript typescript-language-server
# LSP: Bash
sudo npm install -g bash-language-server
# LSP: Vvim
sudo npm install -g vim-language-server
# NPM: Packages
sudo npm install -g jshint prettier-miscellaneous

echo -e "\nInstalling Plugins:"
nvim --headless +PlugInstall +qall
# nvim --headless +TSInstall +qpython +qjsonc +qtsx +qbash +qjavascript


echo "Get .NET framework"
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O ~/packages-microsoft-prod.deb
sudo dpkg -i ~/packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get install -y aspnetcore-runtime-3.1

set +x
echo
echo "Install NVIM Complete."
