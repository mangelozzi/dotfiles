sudo cp -r $HOME/.config/fonts/Roboto-Mono/ /usr/share/fonts/truetype/Roboto-Mono/
sudo chmod 644 /usr/share/fonts/truetype/Roboto-Mono/*
sudo chmod 755 /usr/share/fonts/truetype/Roboto-Mono
echo "Rebuilding font cache so can use fonts immediately"
fc-cache -f -v
