#
# Utility aliases and functions
#

alias df='df -h'
alias du='du -h'

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

if (( ${+commands[fortune]} )); then
  alias fortune-chucknorris="fortune -a ${HOME}/.local/share/fortune"
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

if (( ${+commands[nvim]} )); then
  alias v="nvim"
  alias vi="nvim"
  alias vim="nvim"
  alias vcfg="nvim --cmd \"cd ~/.config/nvim\" ~/.config/nvim/init.lua"
fi

if (( ${+commands[yt-dlp]} )); then
  alias youtube-download-video="yt-dlp"
  alias youtube-download-transcript="yt-dlp --write-auto-sub --skip-download --sub-format srt"
fi

if (( ${+commands[zoxide]} )); then
  # comment the alias below if it breaks functionality
  alias cd="z"
fi

weather() {
  xh "wttr.in/$*"
}

terminfo-ghostty-export() {
  if (( $# == 0 )); then
    echo "Usage: terminfo-ghostty-export <file>" >&2
    return 1
  fi
  infocmp -x xterm-ghostty > $1
}

terminfo-ghostty-import() {
  if (( $# == 0 )); then
    echo "Usage: terminfo-ghostty-import <file>" >&2
    return 1
  fi
  tic -x $1
}

#
# Colours
#

# See https://no-color.org
if [[ -z ${NO_COLOR} ]]; then

  # grep colours
  if (( ! ${+GREP_COLOR} )) export GREP_COLOR='37;45'               #BSD
  if (( ! ${+GREP_COLORS} )) export GREP_COLORS="mt=${GREP_COLOR}"  #GNU
  if [[ ${OSTYPE} == (openbsd|solaris)* ]]; then
    if (( ${+commands[ggrep]} )) alias grep='ggrep --color=auto'
  elif (( ${+commands[grep]} )); then
    alias grep='grep --color=auto'
  fi

  # less colours
  if (( ! ${+LESS_TERMCAP_mb} )) export LESS_TERMCAP_mb=$'\E[1;31m'  # Begins blinking.
  if (( ! ${+LESS_TERMCAP_md} )) export LESS_TERMCAP_md=$'\E[1;31m'  # Begins bold.
  if (( ! ${+LESS_TERMCAP_me} )) export LESS_TERMCAP_me=$'\E[0m'     # Ends mode.
  if (( ! ${+LESS_TERMCAP_ue} )) export LESS_TERMCAP_ue=$'\E[0m'     # Ends underline.
  if (( ! ${+LESS_TERMCAP_us} )) export LESS_TERMCAP_us=$'\E[1;32m'  # Begins underline.
fi

#
# ls GNU vs. BSD
#

if whence dircolors >/dev/null && ls --version &>/dev/null; then
  # GNU

  # ls aliases
  alias lx='ll -X' # long format, sort by extension
  if [[ -z ${NO_COLOR} ]]; then
    # ls colours
    if [[ -s ${HOME}/.dir_colors ]]; then
      eval "$(dircolors --sh ${HOME}/.dir_colors)"
    elif (( ! ${+LS_COLORS} )); then
      export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
    fi
    alias ls='ls --group-directories-first --color=auto'
  else
    alias ls='ls --group-directories-first'
  fi

  # Always wear a condom
  alias chmod='chmod --preserve-root -v'
  alias chown='chown --preserve-root -v'
else
  # BSD

  if [[ -z ${NO_COLOR} ]]; then
    # ls colours
    export CLICOLOR=1
    if (( ! ${+LSCOLORS} )) export LSCOLORS=ExfxcxdxbxGxDxabagacad
    # Stock OpenBSD ls does not support colors at all, but colorls does.
    if [[ ${OSTYPE} == openbsd* && ${+commands[colorls]} -ne 0 ]]; then
      alias ls=colorls
    fi
  fi
fi

