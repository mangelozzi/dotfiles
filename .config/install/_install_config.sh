#!/usr/bin/env bash

# Based on https://mjones44.medium.com/storing-dotfiles-in-a-git-repository-53f765c0005d

cd $HOME
git clone --bare git@github.com:mangelozzi/dotfiles.git $HOME/.dotfiles

# define dot alias locally since the dotfiles
# aren't installed on the system yet
function dot {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

dot checkout
dot config status.showUntrackedFiles no
