source lib.sh

echo
echo "gitk and git setup"
echo "------------------"
sudo apt install -y gitk
git config --global user.email "mangelozzi@gmail.com"
git config --global user.name "Michael Angelozzi"
# By default set branch's to track origin: git push --set-upstream origin ... for each new branch
git config --global push.default simple

echo
echo "pinta"
echo "-----"
sudo apt install -y pinta

echo
echo "SpeedCrunch"
echo "-----------"
read -p "Press <ENTER> to continue..."
sudo apt install -y speedcrunch
echo
echo "Change settings"
echo "Settings are stored in ~/.config/SpeedCrunch/SpeedCrunch.ini"
echo
echo "Change the following settings:"
echo '`Settings` -> `Display` -> `Color scheme` -> `Terminal`'
echo '`Settings` -> `Display` -> `Font` -> `Noboto 14 bold`'
speedcrunch &
read -p "Waiting for settings to be changed"

echo
echo "chrome"
echo "------"
read -p "Press <ENTER> to continue..."
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
        echo
        echo "Set up the profiles in the following order so it matches i3"
        echo "  1. personnel"
        echo "  2. work"
        echo "  3. mom"
        google-chrome
        read -p "to setup chrome"
        ;;
    esac
else
    echo "Chrome already installed"
fi


echo "libre office"
echo "------------"
read -p "Press <ENTER> to continue..."
sudo apt install libreoffice


echo "DBeaver"
echo "-------"
read -p "Press <ENTER> to continue..."
echo "Download from https://dbeaver.io/download/"
echo "cd ~/Downloads"
echo "sudo dpkg -i dbeaver-ce_22.3.2_amd64.deb"
echo "Setup:"
echo "    1. Choose a postgres connection"
echo "    2. Use the DJANGO_DB_USER // DJANGO_DB_PASS from the cfg1_custom.py file"
echo "    3. Select the 'Postgres' Tab -> 'Settings' -> 'Show all databases'"
read -p "Press <ENTER> to continue..."
