# init zoxide and set alias to use it instead of `cd`
if (( ${+commands[zoxide]} )); then
  eval "$(zoxide init zsh)"
  # comment the alias below if it breaks functionality
  alias cd="z"
fi
