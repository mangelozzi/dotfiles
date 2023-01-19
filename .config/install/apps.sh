source lib.sh

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
