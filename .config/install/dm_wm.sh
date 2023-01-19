echo
echo "LY DM - Ly Display Manager (greeter)"
echo "------------------------------------"
read -p "Press <ENTER> to continue..."
echo
# https://github.com/fairyglade/ly
# Dependencies
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
# First disable the default Gnome display manager
sudo systemctl disable gdm.service
# sudo systemctl disable lightdm.service
mkdir -p ~/tools/
cd ~/tools/
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
read -p 'About to test the greeter press CTRL+C to exit...'
make run
read -p 'If it was not successful, press CTRL+C to abort installation, <ENTER> to continue...'
sudo make install installsystemd
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service
mkdir -p ~/.local/bin/
cat <<EOF >> ~/.local/bin/start-swith-with-gnome-keyring.sh
#!/usr/bin/env sh
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
/sbin/sway
EOF
sudo chmod +x /home/michael/.local/bin/start-swith-with-gnome-keyring.sh


echo
echo "I3 DEPENDENCIES"
echo "---------------"
read "Press <ENTER> to continue..."

# Media player key support used with i3
sudo apt install -y playerctl

# Backlight screen brightness
sudo apt install -y xbacklight

# Wallpaper
# sudo apt install -y feh

# Multiple screen support
sudo apt install -y arandr

# Numlock support
sudo apt install -y numlockx

# Set the system font size
sudo apt install -y lxappearance

# Screen shot tool (maim = make image)
sudo apt install -y maim

# Python package for interfacing is i3
python3 -m pip install i3ipc

# Indicator sound output switcher (choose sound output to which device)
sudo apt-add-repository ppa:yktooo/ppa
sudo apt-get update
sudo apt-get install indicator-sound-switcher

# Setup the Keyboard remap
sudo ln -s /home/$USER/.config/x11/xkb/mylayout /usr/share/X11/xkb/symbols/mylayout
sudo ln -s /home/$USER/.config/x11/xorg.conf/90-custom-kbd.conf /usr/share/X11/xorg.conf.d/90-custom-kbd.conf


echo
echo "I3WM - Window Manager"
echo "---------------------"
read "Press <ENTER> to continue..."
echo
echo "- Installation from <https://i3wm.org/docs/repositories.html>:"
echo "- May have fix 'sudo nvim /etc/apt/sources.list.d/sur5r-i3.list' by adding the architecture flag:"
echo "    deb http://debian.sur5r.net/i3/ ..."
echo "    to"
echo "    deb [arch=amd64] http://debian.sur5r.net/i3/ ..."

cd ~/appimages
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2022.02.17_all.deb keyring.deb SHA256:52053550c4ecb4e97c48900c61b2df4ec50728249d054190e8a0925addb12fc6
sudo apt install ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
sudo apt update

echo Make sure the version is right before installing it:
apt-cache show i3
read -p 'Press <ENTER> to continue (CTRL+C to abort)...'

sudo apt install -y i3
