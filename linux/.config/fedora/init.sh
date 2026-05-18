#!/bin/sh

# NOTE: Do not execute this script directly. Execute the steps below manually

cd ~

# install base packages
sudo dnf install -y @development-tools gcc-c++ git stow which zsh

# clone my dotfiles config
git clone https://github.com/giogt/dotfiles.git ~/.dotfiles

# install terminfo for the Ghostty terminal emulator
tic -x ~/.dotfiles/shell/.config/terminfo/ghostty.terminfo

# change shell to zsh
sudo chsh -s /usr/bin/zsh giogt

# NOTE: if using Lima VM, restart before next steps

# install zimfw
curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh

# install mise
curl https://mise.run | sh

# move conflict files conflicting with the ones provided by dotfiles
mv ~/.zshrc ~/.zshrc.bak 
mv ~/.zimrc ~/.zimrc.bak

# NOTE: add ~/.config/mise/github_tokens.toml before next steps to avoid Github rate limit with Mise

stow -d ~/.dotfiles shell
stow -d ~/.dotfiles linux
stow -d ~/.dotfiles dev

