# Add this to Windows terminal settings to enable copy/paste with Ctrl+C/V:
#     "keybindings":
#     [
#         {
#             "id": "Terminal.PasteFromClipboard",
#             "keys": "ctrl+shift+v"
#         },
#         {
#             "id": "Terminal.CopyToClipboard",
#             "keys": "ctrl+c"
#         },
#         {
#             "id": "Terminal.PasteFromClipboard",
#             "keys": "ctrl+v"
#         },
#         {
#             "id": "Terminal.CopyToClipboard",
#             "keys": "ctrl+shift+c"
#         }
#     ],

# IOEC
# IOEC=~/ioec/admin
IOEC=/mnt/c/Users/Michaela/ioec

# DIRS
alias cdi="cd $IOEC"
alias cda="cd $IOEC/admin"

alias cdg="cd ~/Ggateway/Gateway"
alias cdgn="cd ~/Ggateway/Gateway/Gateway.NextClient"
alias cdgc="cd ~/Ggateway/Gateway/Gateway.Client"

# Visual Studio (Windows partition)
alias cdgv="cd /mnt/c/Users/Michaela/ioec/GatewayVS"

# Windows user
alias cdu='cd /mnt/c/Users/Michael/'
# Windows work
alias cdw='cd /mnt/c/work/'

# Angular (next/gw2) start
alias pmr="npm run ng serve"

# Angular.js (client/gw1) start
alias fe="cd $IOEC/gateway/Gateway/Gateway.Client; npm start"
alias fen="cd $IOEC/gateway/Gateway/Gateway.NextClient; npm start"

cdgn
