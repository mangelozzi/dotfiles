#!/bin/bash

# PROJECTS
# --------
alias lc="source ~/linkcube/script/console.sh"
alias term="source ~/terminal/script/console.sh"
alias djangodev="source ~/.venv/djangodev/bin/activate"
alias ml="source ~/.venv/ml/bin/activate"

# TOOLS
alias rpiboot="sudo ~/tools/rpiboot/rpiboot"
alias rpiboot2="sudo ~/tools/usbboot-msg/rpiboot"
alias mycal="cal -A3 -B2"

# SSH

# Don't SSH into github, just used for authentication
alias sshterm="ssh-add ~/.ssh/terminal_login"

# Test this has been sourced
alias dottest='echo "bashrc_ext was sourced"'

alias fix='stty sane'

# `fd` already taken, create a convenient alias for the search tool:
alias fd=fdfind

# Windows user
alias cdu='cd /mnt/c/Users/Michael/'
# Windows work
alias cdw='cd /mnt/c/work/'

# Commons dirs

# Cryptomator
alias cdc='cd ~/.local/share/Cryptomator/mnt'

# Neovim
alias vim=nvim
alias cdn='cd ~/.config/nvim'
# Neovim Tmp/ or Plugin dir
alias cdt='cd ~/.config/nvim/tmp'
alias cdp='cd ~/.config/nvim/tmp'

# GITHUB add key
# Hostname/IP varies, so can only add key
# alias github='ssh-add -l || ssh-add ~/.ssh/github_dev'
# alias github='ssh-add -l | grep "KaFOpY9S84" || ssh-add ~/.ssh/github_dev'
github() {
    ssh-add -l | grep "KaFOpY9S84" || ssh-add ~/.ssh/github_dev
}

# Git Dot files
alias dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias dotp="github && git --git-dir=$HOME/.dotfiles --work-tree=$HOME push"

# Git
alias gs='git status'
alias gu='git add -u'
alias gupy='git add -u "*.py"'
alias guhtml='git add -u "*.html"'
alias guscss='git add -u "*.scss" "*.sass"'
alias gujs='git add -u "*.js"'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='github && git push'
alias gm='git commit --amend --no-edit'
alias gmp='github && git commit --amend --no-edit && git push -f'
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
