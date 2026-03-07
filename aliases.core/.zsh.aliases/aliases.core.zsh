# eza (ls modern replacement)
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

alias curl_post_json="curl -X POST -H \"Content-Type: application/json\" -d"

weather() {
  xh "wttr.in/$*"
}
