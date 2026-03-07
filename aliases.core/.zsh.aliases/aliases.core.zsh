alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias e="eza -g --group-directories-first --git"
alias el="eza -lg --group-directories-first --git"
alias ea="eza -ag --group-directories-first --git"
alias ela="eza -lag --group-directories-first --git"

alias curl_post_json="curl -X POST -H \"Content-Type: application/json\" -d"

weather() {
  xh "wttr.in/$*"
}
