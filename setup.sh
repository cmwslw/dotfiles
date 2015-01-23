git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mv ~/.vimrc ~/.vimrc.bak
ln -s ~/dotfiles/vimrc ~/.vimrc

mkdir ~/.vimswap
mkdir ~/.vimundo

vim +PluginInstall +qall
