ln -b -s ~/dotfiles/bashrc ~/.bashrc
ln -b -s ~/dotfiles/bashrc.functions ~/.bashrc.functions
ln -b -s ~/dotfiles/inputrc ~/.inputrc
ln -b -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -b -s ~/dotfiles/vim ~/.vim
ln -b -s ~/dotfiles/vim/vimrc ~/.vimrc
ln -b -s ~/dotfiles/gitconfig ~/.gitconfig
ln -b -s ~/dotfiles/gitignore.global ~/.gitignore

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
