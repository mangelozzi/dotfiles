source lib.sh

echo
echo "git setup"
echo "--------------"
git config --global user.email "mangelozzi@gmail.com"
git config --global user.name "Michael Angelozzi"

echo
echo "input-remapper"
echo "--------------"
read -p "Press <ENTER> to continue..."
sudo apt install -y git python3-setuptools gettext
mkdir -p ~/tools
cd ~/tools
git clone https://github.com/sezanzeb/input-remapper.git
cd input-remapper && ./scripts/build.sh
sudo apt install ./dist/input-remapper-1.5.0.deb


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
        read -p "to setup chrome"
        google-chrome
        ;;
    esac
else
    echo "Chrome already installed"
fi
