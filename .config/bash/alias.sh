#!/bin/bash

# Critical
# --------
alias ll="ls -la"

# PROJECTS
# --------
alias lc="source ~/linkcube/script/console.sh"
alias term="source ~/terminal/script/console.sh"
alias djangodev="source ~/.venv/djangodev/bin/activate"
alias ml="source ~/.venv/ml/bin/activate"

# APPS
# --------
alias chrome="sudo apt-get update; sudo apt-get --only-upgrade install google-chrome-stable"

# TOOLS
alias rpiboot="sudo ~/tools/rpiboot/rpiboot"
alias rpiboot2="sudo ~/tools/usbboot-msg/rpiboot"
# -b to highlight the current day
alias mycal="ncal -b -A3 -B2"
alias mycal12="ncal -b -A12 -B0"
# Can't append it with '&' because then its treated as an argument to the command
# alias inkscape="~/appimages/Inkscape-b0a8486-x86_64.AppImage"
inkscape() { ~/appimages/Inkscape-b0a8486-x86_64.AppImage >/dev/null 2>&1 & }

# MUST supply name of dir to unmount
# E.g. ~/.local/share/Cryptomator/mnt; fusermount3 -u Mighty_Secure
alias cryptofix="~/.local/share/Cryptomator/mnt; fusermount3 -u "

# SSH

# Not to SSH into github, just used for authentication for terminals
# 1. Copy key from NanoCube_Secure/terminal/login/terminal_login to ~/.ssh
# 2. Add the key with: `sshterm`
# 3. Connect to the terminal with: `ssh terminal`
alias sshterm="ssh-add ~/.ssh/terminal_login"

# Test this has been sourced
alias dottest='echo "bashrc_ext was sourced"'

alias fix='stty sane'

# `fd` already taken, create a convenient alias for the search tool:
alias fd=fdfind

# Commons dirs

# Cryptomator
alias cdc='cd ~/.local/share/Cryptomator/mnt'

# Neovim
alias vim=nvim
alias cdn='cd ~/.config/nvim'
# Neovim Tmp/ or Plugin dir
alias cdt='cd ~/.config/nvim/tmp'
alias cdp='cd ~/.config/nvim/tmp'

# GIT development add key
# Hostname/IP varies, so can only add key
# alias gitdev='ssh-add -l || ssh-add ~/.ssh/gitdev'
# alias gitdev='ssh-add -l | grep "KaFOpY9S84" || ssh-add ~/.ssh/gitdev'
gitdev() {
    ssh-add -l | grep "KaFOpY9S84" || ssh-add ~/.ssh/gitdev
}

# GIT SET REPOS
alias gitdot='export GIT_DIR=~/.dotfiles GIT_WORK_TREE=~'
alias gitlc='export GIT_DIR=~/linkcube/.git GIT_WORK_TREE=~/linkcube'
alias gitterm='export GIT_DIR=~/terminal/.git GIT_WORK_TREE=~/terminal'
# git remote set-url origin https://github.com/mangelozzi/mangelozzi.github.io.git
# git remote set-url origin git@github.com:mangelozzi/mangelozzi.github.io.git
alias grso="git remote set-url origin"

# Git Dot files
dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dot="$dot"
# Purposes don't have many dot aliases to keep default git skills sharp
alias dotp="gitdev && $dot push"
alias dota="dot commit --amend --no-edit"
alias dotap="dot commit --amend --no-edit; gitdev && dot push -f"

# Git
alias gl='git log'
alias gs='git status'
alias gco='git checkout'
alias gb='git branch'
# List branches on remote
alias gbr='git branch -r'
alias gcmp='gitdev && git checkout master && git pull'
alias ga='git add -A'
alias gu='git add -u'
# alias gupy='git add -u "*.py"'
# alias guhtml='git add -u "*.html"'
# alias guscss='git add -u "*.scss" "*.sass"'
# alias gujs='git add -u "*.js"'
alias gamin='git add -u **/*.min.css **/*.min.js'
alias gc='git commit -m'
# ---
# Create a new branch with any of the current changes, and change the HEAD to start tracking it.
alias gcb='git checkout -b '
# After creating a branch, make it track origin
alias gpuo='git push -u origin'
# Git new branch...
alias gnb='git checkout -b $1; git push -u origin $1;'
# ---
alias gp='gitdev && git push'
alias gm='git commit --amend --no-edit'
alias gmp='gitdev && git commit --amend --no-edit && git push -f'
# Show a list of patched changes in the file, e.g. gp foo.txt
# alias gp='git log -p'
# -R to turn removed lines into added lines, so whitespace can be be highlighted.
# Makes add and deleted lines unreliable and confusing
alias gd="git diff --diff-filter=M --ws-error-highlight=all ':!*.min.js' ':!*.min.css'"
# Git Word Diff
alias gwd="git diff --diff-filter=M --ws-error-highlight=all --color-words ':!*.min.js' ':!*.min.css'"
# Git Char Diff
alias gcd="git diff --diff-filter=M --ws-error-highlight=all --color-words=. ':!*.min.js' ':!*.min.css'"
alias gdpy="git diff --diff-filter=M --ws-error-highlight=all '*.py'"
alias gdhtml="git diff --diff-filter=M --ws-error-highlight=all '*.html'"
alias gdjs="git diff --diff-filter=M --ws-error-highlight=all '*.js'"
alias gdsass="git diff --diff-filter=M --ws-error-highlight=all '*.sass' '*.scss'"

# Gnome Settings (Default Ubuntu Panel ---
# Setting this environment variable is required to make the appearance panel appear in the options
# XDG_CURRENT_DESKTOP=ubuntu:GNOME
alias settings="gnome-control-center &"
alias update="update-manager"

# Windows user
alias cdu='cd /mnt/c/Users/Michael/'
# Windows work
alias cdw='cd /mnt/c/work/'

# IOEC
# IOEC=~/ioec/admin
IOEC=/mnt/c/Users/Michaela/ioec
alias cdi="cd $IOEC"
alias cda="cd $IOEC/admin"

alias cdg="cd ~/Ggateway/Gateway"
alias cdG="cd ~/Ggateway/Gateway/Gateway.NextClient"
alias cdgc="cd ~/Ggateway/Gateway/Gateway.Client"
alias cdgn="cd ~/Ggateway/Gateway/Gateway.NextClient"

alias fe="cd $IOEC/gateway/Gateway/Gateway.Client; npm start"
alias fen="cd $IOEC/gateway/Gateway/Gateway.NextClient; npm start"
alias fortistart="sudo systemctl start forticlient.service"
alias fortistop="sudo systemctl stop forticlient.service"
alias story="npm run storybook"
