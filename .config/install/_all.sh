SCRIPT_PATH="$(realpath $0)"
SCRIPT_DIR="$(dirname $SCRIPT_PATH)"
cd $SCRIPT_DIR

echo
ppause "Press <ENTER> to run bash.sh ..."
bash bash.sh

echo
ppause "Press <ENTER> to run utils.sh ..."
bash utils.sh

echo
ppause "Press <ENTER> to run os.sh ..."
bash os.sh

echo
ppause "Press <ENTER> to run dm_wm.sh ..."
bash dm_wm.sh

echo
ppause "Press <ENTER> to run nvim.sh ..."
bash nvim.sh

echo
ppause "Press <ENTER> to run apps.sh ..."
bash apps.sh

echo
echo "COMPLETE."
