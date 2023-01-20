SCRIPT_PATH="$(realpath $0)"
SCRIPT_DIR="$(dirname $SCRIPT_PATH)"
cd $SCRIPT_DIR

echo
echo "bash.sh"
echo "======="
read -p "Press <ENTER> to continue..."
bash bash.sh

echo
echo "utils.sh"
echo "========"
read -p "Press <ENTER> to continue..."
bash utils.sh

echo
echo "os.sh"
echo "====="
read -p "Press <ENTER> to continue..."
bash os.sh

echo
echo "dm_wm.sh"
echo "========"
read -p "Press <ENTER> to continue..."
bash dm_wm.sh

echo
echo "nvim.sh"
echo "========"
read -p "Press <ENTER> to continue..."
bash nvim.sh

echo
echo "apps.sh"
echo "======="
read -p "Press <ENTER> to continue..."
bash apps.sh

echo
echo "COMPLETE."
