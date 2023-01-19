SCRIPT_PATH="$(realpath $0)"
SCRIPT_DIR="$(dirname $SCRIPT_PATH)"
cd $SCRIPT_DIR

bash bash.sh
bash utils.sh
bash os.sh
bash nvim.sh
bash dm_wm.sh
bash apps.sh
echo
echo "COMPLETE."
