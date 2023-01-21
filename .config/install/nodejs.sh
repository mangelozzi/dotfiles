# NPM

echo "Setting script to exit on first error"
set -e

# Ubuntu 22.04 only has version 12 in ppa, require at least 18
# If require a certain version of node (refer to https://github.com/nodesource/distributions):
sudo apt install -y curl
echo "Adding [arch=amd64] so dont get i386 not supported error..."
echo "deb [arch=amd64] http://debian.sur5r.net/i3/ jammy universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
echo "Now nodejs 18 is available to install with apt..."
echo "If installation fails try: 'sudo apt remove libnode72'"
sudo apt-get install -y nodejs

# sudo apt install -y nodejs
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
