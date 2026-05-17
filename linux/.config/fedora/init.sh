#!/bin/sh

cd ~

# install base packages
sudo dnf install -y eza fzf git nvim stow which zoxide zsh

# install zimfw
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# install mise
curl https://mise.run | sh

# move conflict files conflicting with the ones provided by dotfiles
mv ~/.zshrc ~/.zshrc.bak 
mv ~/.zimrc ~/.zimrc.bak

# clone my dotfiles config and apply it
git clone https://github.com/giogt/dotfiles.git ~/.dotfiles
stow -d ~/.dotfiles shell

# install terminfo for the Ghostty terminal emulator
tic -x ~/.config/terminfo/ghostty.terminfo

# change shell to zsh
sudo chsh -s /usr/bin/zsh giogt

