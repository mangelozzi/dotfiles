source lib.sh

echo
echo "Remapping Escape->Caps, Caps->SuperL, SuperL->Escape"
echo "---------"
read -p "Press <ENTER> to continue..."
sudo /home/michael/.config/usr_share_X11_xkb_keycodes/install

echo
echo "Grub"
echo "----"
read -p "Press <ENTER> to continue..."
sudo /home/michael/.config/usr_share_X11_xkb_keycodes/install
echo
echo "Change GRUB_TIMEOUT=10 to 2 seconds"
read -p "Press <ENTER> to open vi and perform the change..."
sudo vi /etc/default/grub
sudo update-grub

echo
echo "setup Terminal"
echo "---------"
echo "Setting CTRL+Tab to be next Terminal tab, and SHIFT+CTRL+Tab to be the previous"
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'
echo "Note: ALT+1 is the first tab, ALT+2, is the second etc"
echo
echo "1. Select this terminal menu hamburger icon -> 'Preferences"
echo "2. Left menu 'Unnamed'"
echo "3. Check 'Custom font'"
echo "4. Click the name of the font and chaange to 'Noto Mono Bold'"
echo "5. Select the 'Colors' Tab"
echo "6. Lighten up the blues and purples"
echo "7. Under Unnamed -> Sound -> Uncheck 'Terminal bell'"
echo
read -p "Press <ENTER> to continue..."

echo
echo "Lets set vi to be the default editor for config system files:"
sudo update-alternatives --config editor

echo
echo "Disable when close lid it powers down"
echo "Uncomment and change the following property to ignore:"
echo "    HandleLidSwitch=ignore"
echo " And add the docked equivalent:"
echo "    HandleLidSwitchDocked=ignore"
read -p "Press <ENTER> to continue..."
sudo vi /etc/systemd/logind.conf
echo "Note: The change will only be active after next reboot"

echo
echo "Sudoers"
sudo cp ~/.config/os/sudoers /etc/sudoers.d/sudoers
sudo chown root:root /etc/sudoers.d/sudoers
sudo chmod 440 /etc/sudoers.d/sudoers
