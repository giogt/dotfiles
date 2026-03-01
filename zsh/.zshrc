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

# --------------------- #
# Aliases and functions #
# --------------------- #

for file in ${HOME}/.zsh.aliases/*.zsh(N); do
  source "$file"
done

# --------- #
# CLI tools #
# --------- #

# fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# --------- #
# Dev tools #
# --------- #

# Rust
export PATH="${PATH}:${HOME}/.cargo/bin"
. "${HOME}/.cargo/env"

# Jetbrains toolbox
export PATH="${PATH}:/Users/giogt/Library/Application Support/JetBrains/Toolbox/scripts"

# Podman - Docker compatibility
alias docker=podman
export PODMAN_HOST="${HOME}/.local/share/containers/podman/machine/podman.sock"
# export DOCKER_HOST="unix:///var/run/docker.sock"
# export DOCKER_HOST="unix://$(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')"

# Podman zsh completion
# if they are out of date, you can generate the completions again using the following command
# podman completion zsh -f ${HOME}/.zim/modules/zsh-completions/src/_podman


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
  # Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
  if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
    source /opt/homebrew/opt/zimfw/share/zimfw.zsh init
  fi
  # Initialize modules.
  source ${ZIM_HOME}/init.zsh
fi

# ----------------------------------------------- #
# Extra initialization that needs to go after zim #
# ----------------------------------------------- #

# execute zsh post scripts, if any
for file in ${HOME}/.zsh.post/*.zsh(N); do
  source "$file"
done

