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
if [ $? = 0 ]; then
    echo "Checked out dotfiles";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    # create a directory to backup existing dotfiles to
    mkdir -p .dotfiles-backup
    dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi

dot checkout
dot config status.showUntrackedFiles no
