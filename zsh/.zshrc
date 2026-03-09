# ------- #
# zsh.pre #
# ------- #

# execute zsh pre scripts, if any
for file in ${HOME}/.zsh.pre/*.zsh(N); do
  source "$file"
done

#
# ---------- #
# Input mode #
# ---------- #

# Setting $EDITOR to nvim (see .zprofile) sets the shell's input mode to vi mode.
# If we want emacs mode instead, we need to set it explicitly.
set -o emacs

# --------- #
# CLI tools #
# --------- #

# fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# zoxide
if (( ${+commands[zoxide]} )); then
  eval "$(zoxide init zsh)"
  alias cd="z"
  alias cdi="zi"
fi

# --- #
# Zim #
# --- #

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

# --------------------- #
# Aliases and functions #
# --------------------- #

for file in ${HOME}/.zsh.aliases/*.zsh(N); do
  source "$file"
done

# -------- #
# zsh.post #
# -------- #

# execute zsh post scripts, if any
for file in ${HOME}/.zsh.post/*.zsh(N); do
  source "$file"
done

