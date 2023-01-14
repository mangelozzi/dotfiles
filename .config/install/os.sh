source lib.sh

echo "Disable piece of rubbish AMD radeon graphics card"
echo "Change the line:"
echo '    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"'
echo "        to"
echo '    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash radeon.modeset=0"'
echo "Copy this text -> splash radeon.modeset=0"
pause
sudo vi /etc/default/grub


echo
echo "Lets manually set some settings"
echo "System settings"
echo "1. Top right select settings"
echo "2. Left menu 'Display' -> Enable 'Fractional Scaling' and set to '125%'"
echo "3. Left menu 'Privacy' -> 'Screen Lock' -> disable away"
echo "4. Left menu 'Accessibility' -> 'Typing Assist (AcessX) -> 'Bounce keys' -> Enable with shortest acceptance delay"
pause

echo
echo "setup Terminal"
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
pause

echo
echo "Lets set vi to be the default editor for config system files:"
sudo update-alternatives --config editor

echo
echo "Change the first line:"
echo "Defaults        env_reset"
echo "  to"
echo "Defaults        env_reset,timestamp_timeout=1440"
pause "copy the change then continue"
sudo visudo

echo
echo "Disable when close lid it powers down"
echo "Uncomment and change the following property to ignore:"
echo "    HandleLidSwitch=ignore"
echo " And add the docked equivalent:"
echo "    HandleLidSwitchDocked=ignore"
pause
sudo vi /etc/systemd/logind.conf
echo "Note: The change will only be active after next reboot"

pause "install chrome"
if ! command -v google-chrome &> /dev/null
then
    pause "Install chrome"
    read -p "Install Chrome (y/n)? " CHROME
    case ${CHROME:0:1} in
    y|Y )
        mkdir -p ~/appimages/
        cd ~
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        echo
        echo "Only need to do this if graphics card is enabled:"
        echo "Type 'chrome://settings/?search=hardware' into chrome"
        echo "And uncheck use hardware 'Use hardware acceleration when available'"
        echo "To speed up Chrome if using M2800"
        pause "to setup chrome"
        google-chrome
        ;;
    esac
else
    echo "Chrome already installed"
fi

echo
echo "Dock"
echo "1. Right click firefox remove from favourites"
echo "2. Bottom left clicks apps icon and click Chrome, right click its icon and select add to favourites"
pause
