#
# core aliases and functions
#

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

