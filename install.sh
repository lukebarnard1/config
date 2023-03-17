#!/bin/bash
#

script_dir=$(dirname "$(readlink -f "$0")")

rm ~/.bashrc

ln -s $script_dir/config/dev ~/.config/dev
ln -s $script_dir/config/dev/bash/init.bashrc ~/.bashrc
ln -s $script_dir/config/nvim ~/.config/nvim

# Install neovim
#
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Install vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
  --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

