# Setting $EDITOR to nvim (see .zprofile) sets the shell's input mode to vi mode.
# If we want emacs mode, we need to set it explicitly.
set -o emacs

#
# Zim
#

# If INTELLIJ_ENVIRONMENT_READER is defined, don't initialize zim.
#
# On MacOS, GUI apps inherit a relatively empty environment. To ensure dev tools launched from the IDE are properly
# configured, JetBrains IDEs attempt to load the shell environment on startup in interactive mode, but without access
# to a terminal.
# Loading Zim tries to interact with a terminal, therefore causing the IDEs shell environment loading to fail.
# For more details, see: https://youtrack.jetbrains.com/articles/SUPPORT-A-1727/Shell-Environment-Loading
if [ -z "${INTELLIJ_ENVIRONMENT_READER}" ]; then
  ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

  # suggested option in .zimrc to boost zsh autosuggestions performance
  ZSH_AUTOSUGGEST_MANUAL_REBIND=1

  # Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
  if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
    source /opt/homebrew/opt/zimfw/share/zimfw.zsh init
  fi
  # Initialize modules.
  source ${ZIM_HOME}/init.zsh
fi

#
# Init and config shell tools
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
# Load additional config
#

source_if_exists() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

source_if_exists "$HOME/.config/zsh/core.zsh"
source_if_exists "$HOME/.config/zsh/dev.zsh"

if [[ "$OSTYPE" == darwin* ]]; then
  source_if_exists "$HOME/.config/zsh/macos.zsh"
fi
