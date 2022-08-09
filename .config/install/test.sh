source lib.sh

echo "Disable piece of rubbish AMD radeon graphics card"
echo "Change the line:"
ehco '    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"'
echo "        to"
echo '    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash radeon.modeset=0"'
echo "Copy this text -> splash radeon.modeset=0"
pause
echo "after the pause"
