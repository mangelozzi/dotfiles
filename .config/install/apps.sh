source lib.sh

echo
echo "git setup"
echo "--------------"
git config --global user.email "mangelozzi@gmail.com"
git config --global user.name "Michael Angelozzi"

echo
echo "xkeysnail"
echo "---------"
read -p "Press <ENTER> to continue..."
# xkeysnail requires sudo pip install, and sudo to run!
sudo apt install python3-pip
sudo pip3 install xkeysnail

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
echo "node"
echo "----"
read -p "Press <ENTER> to continue..."
sudo apt install -y nodejs
node -v
npm -v


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
