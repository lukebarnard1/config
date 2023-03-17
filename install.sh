#!/bin/bash

cd ~/.config

mkdir dev
git clone git@github.com:lukebarnard1/config.git dev

ln -s dev/init.bash ~/.bashrc

mkdir nvim
ln -s dev/init.vim nvim/init.vim

# Install neovim
#
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
