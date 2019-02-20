#!/bin/bash

# Set zsh as default shell
sudo chsh -s /bin/zsh dev

# Run dotfiles
rm -rf $HOME/.config/dotfiles
git clone https://github.com/loric-/dotfiles.git $HOME/Lab/dotfiles
cd $HOME/Lab/dotfiles && python3 link.py

# Install vim plugins
vim +'PlugInstall --sync' +qa

# Apply colors
xrdb $HOME/.Xresources

# Install lightdm instead of gdm
sudo apt-get remove -y gdm3
sudo apt-get install -y lightdm

# Set i3 as default session
echo "[SeatDefaults]"           | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
echo "autologin-user=dev"       | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
echo "autologin-user-timeout=0" | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
echo "user-session=i3"          | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-autologin-vagrant.conf
