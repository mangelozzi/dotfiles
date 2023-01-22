# Tools generally are installed to ~/tools
# And their source could be in source control if small enough

sudo apt install -y libgdbm-dev libreadline-dev
mkdir -p ~/tools/
tar xf ~/.config/tools/rhyme-0.9.tar.gz -C ~/tools/
cd ~/tools/
make
sudo make install
echo "Testing what rhymes with cat..."
rhyme "cat"
