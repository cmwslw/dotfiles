#!/usr/bin/env bash

# See https://gist.github.com/nicferrier/2277987
REPOSRC=https://github.com/VundleVim/Vundle.vim.git
LOCALREPO=~/.vim/bundle/Vundle.vim

# We do it this way so that we can abstract if from just git later on
LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    echo "Vundle does not exist. Cloning."
    git clone $REPOSRC $LOCALREPO
else
    echo "Vundle already exists. Updating."
    cd $LOCALREPO
    git pull $REPOSRC
fi

echo "Backing up old dotfiles and creating symlinks to new dotfiles."
mv ~/.vimrc ~/.vimrc.bak
ln -s ~/dotfiles/vimrc ~/.vimrc
mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# -p for no error on existing, -v to print each created directory
mkdir -pv ~/.vimswap
mkdir -pv ~/.vimundo

echo "Installing and updating plugins."
vim +PluginInstall! +qall
