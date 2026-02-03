alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias e="eza -g --git"
alias el="eza -lg --git"
alias ea="eza -ag --git"
alias ela="eza -lag --git"

alias curl_post_json="curl -X POST -H \"Content-Type: application/json\" -d"

weather() {
  xh "wttr.in/$*"
}
