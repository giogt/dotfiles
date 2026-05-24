source_if_exists() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

#
# input mode
#

# Setting $EDITOR to nvim (see .zprofile) sets the shell's input mode to vi mode.
# If we want emacs mode, we need to set it explicitly.
bindkey -e

#
# zimfw
#

source_if_exists "$HOME/.config/zsh/zimfw.zsh"

#
# init shell tools
#

# mise must be initialized first, if available
if (( ${+commands[mise]} )); then
  eval "$(mise activate zsh)"
fi

if (( ${+commands[fzf]} )); then
  eval "$(fzf --zsh)"
fi
if (( ${+commands[jj]} )); then
  eval "$(jj util completion zsh)"
fi
if (( ${+commands[starship]} )); then
  eval "$(starship init zsh)"
fi
if (( ${+commands[zoxide]} )); then
  eval "$(zoxide init zsh)"
fi

#
# load additional config
#

source_if_exists "$HOME/.config/zsh/utility.zsh"
source_if_exists "$HOME/.config/zsh/dev.zsh"

if [[ "$OSTYPE" == darwin* ]]; then
  source_if_exists "$HOME/.config/zsh/macos.zsh"
else
  source_if_exists "$HOME/.config/zsh/linux.zsh"
fi

# Lima BEGIN
#
# Please keep this, otherwise Lima VM will keep adding it at every reboot.
#
# Lima END
