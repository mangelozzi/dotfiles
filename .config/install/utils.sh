#!/bin/bash

# Echo commands
set -x

sudo apt update

sh ../i3/dependencies.sh

# Set screen brightness
sudo apt install -y brightnessctl
sudo brightnessctl set 1%

# Curl (required for Neovim appimage download)
# Much faster for big downloads compaared to wget
sudo apt install -y curl

# Wget -very slow to download big files
sudo apt install -y wget

# Speedcrunch
sudo apt install -y speedcrunch

# QDirStat
sudo apt install -y qdirstat

# Ripgrep
# if ! command -v rg &> /dev/null
# then
#     curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
#     sudo dpkg -i ripgrep_11.0.2_amd64.deb
# fi
sudo apt install -y ripgrep

# fd
# bash_ext will create an alias for fd=fd-find
sudo apt install -y fd-find

# FZF
# The Ubuntu 20.04 repo is out of date, require at least 0.22.0
# sudo apt install fzf
if ! command -v fzf &> /dev/null
then
    echo -e "\nFZF will be installed only for the current user."
    read -p "Press <ENTER> to continue..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    bash ~/.fzf/install
    # Make it available for all users, and when activating venv/
    # By default appends to .bashrc a line to add its dir to the path
    # Symbolic link so updates will get new binary
    sudo ln -s $HOME/.fzf/bin/fzf /usr/local/bin/fzf
    echo
    echo -e "\nIn order to be able to use FZF you will have to log out and into bash again."
    read -p "Press <ENTER> to continue..."
fi

# Tree
sudo apt install -y tree

# Neofetch (display system info)
sudo apt install -y neofetch

# Unzip
sudo apt install -y unzip

# Ranger File manager
# Dependency  of ueberzug
sudo apt install -y libxext-dev
# Image preview
python3 -m pip install ueberzug
python3 -m pip install ranger-fm
# Ranger dev icons
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

# --- Script end ---
set +x
echo
echo "Install UTILS complete."
