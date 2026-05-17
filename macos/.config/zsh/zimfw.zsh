#
# zimfw
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

