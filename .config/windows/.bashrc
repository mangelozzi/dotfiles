#!/bin/bash

# Mingw ~/.bashrc file

# Set vim mode
set -o vi

# TOOLS
alias fix='stty sane'

# Windows user
alias cdu='cd /mnt/c/Users/Michael/'
# Windows work
alias cdw='cd /mnt/c/work/'

# Commons dirs

# Neovim
alias vim=nvim
alias cdn='cd ~/.config/nvim'
# Neovim Tmp/ or Plugin dir
alias cdt='cd ~/.config/nvim/tmp'
alias cdp='cd ~/.config/nvim/tmp'

gitdev() {
    ssh-add -l | grep "KaFOpY9S84" || ssh-add ~/.ssh/gitdev
}

# Git Dot files
dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dot="$dot"
# Purposes don't have many dot aliases to keep default git skills sharp
alias dotp="gitdev && $dot push"
alias dota="dot commit --amend --no-edit"
alias dotap="dot commit --amend --no-edit; dot push -f"

# Git
alias gl='git log'
alias gs='git status'
alias gu='git add -u'
alias gb='git branch'
alias gco='git checkout'
# ---
# Create a new branch with any of the current changes, and change the HEAD to start tracking it.
alias gcb='git checkout -b '
# After creating a branch, make it track origin
alias gpuo='git push -u origin'
# Git new branch...
alias gnb='git checkout -b $1; git push -u origin $1;'
# ---
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git push'
alias gm='git commit --amend --no-edit'
alias gmp='git commit --amend --no-edit && git push -f'
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

# IOEC
alias cdG="cd ~/ioec/gateway/Gateway/Gateway.Client"
alias cdg="cd ~/ioec/gateway/Gateway"
alias cdi="cd ~/ioec/"
alias cda="cd ~/ioec/admin"
alias fe="cd ~/ioec/gateway/Gateway/Gateway.Client; npm start"
alias fortistart="sudo systemctl start forticlient.service"
alias fortistop="sudo systemctl stop forticlient.service"
