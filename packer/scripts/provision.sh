#!/bin/bash

# Set zsh as default shell
sudo chsh -s /bin/zsh vagrant

# Run dotfiles
rm -rf $HOME/.config/dotfiles
git clone https://github.com/loric-/dotfiles.git $HOME/.config/dotfiles
cd $HOME/.config/dotfiles && python3 link.py

# Install vim plugins
vim -c 'PlugInstall' -c 'qa!' > /dev/null

# Set i3 as default session
sudo sed -i "/\[daemon\]/a DefaultSession=i3" /etc/gdm3/custom.conf
