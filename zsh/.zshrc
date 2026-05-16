# ---------- #
# Input mode #
# ---------- #

# Setting $EDITOR to nvim (see .zprofile) sets the shell's input mode to vi mode.
# If we want emacs mode, we need to set it explicitly.
set -o emacs

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

# ---------- #
# Init tools
# ---------- #

eval "$(mise activate zsh)"

eval "$(fzf --zsh)"
eval "$(jj util completion zsh)"
eval "$(starship init zsh)"

if (( ${+commands[zoxide]} )); then
  # init zoxide and set alias to use it instead of `cd`
  eval "$(zoxide init zsh)"
  # comment the alias below if it breaks functionality
  alias cd="z"
fi

# ------- #
# Aliases
# ------- #

if (( ${+commands[eza]} )); then
  # set eza aliases
  EZA_OPTS="--group-directories-first --icons=auto --git"
  alias e="eza -g ${EZA_OPTS}"
  alias el="eza -lg ${EZA_OPTS}"
  alias ea="eza -ag ${EZA_OPTS}"
  alias ela="eza -lag ${EZA_OPTS}"

  # Define aliases commonly used for `ls` to use `eza` instead
  # NOTE: do not redefine `ls`, so that scripts relying on `ls` behaviour still work
  alias l="eza -g ${EZA_OPTS}"
  alias ll="eza -lg ${EZA_OPTS}"
  alias la="eza -ag ${EZA_OPTS}"
  alias lla="eza -lag ${EZA_OPTS}"
fi

if (( ${+commands[tmux]} )); then
  # tmux aliases - attach
  alias ta="tmux attach -t"

  # tmux aliases - sessions
  alias tl="tmux list-sessions"
  alias tls="tmux list-sessions"
  alias tn="tmux new-session -s"
  alias tns="tmux new-session -s"
  alias tk="tmux kill-session -t"
  alias tks="tmux kill-session -t"
fi

# -------- #
# zsh.post #
# -------- #

# execute zsh post scripts, if any
for file in ${HOME}/.zsh.post/*.zsh(N); do
  source "$file"
done

