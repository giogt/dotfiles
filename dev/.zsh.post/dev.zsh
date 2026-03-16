alias de="dev-env"

dev-github() {
  local selected_dir=$(fd . "$HOME/dev/github.com/giogt" -d 1 -a --type directory \
      --exclude .git --exclude node_modules/ --exclude target/ \
      | fzf --preview 'ls -l {}' --height=40% --prompt="📁 " \
  )
  if [[ -n "${selected_dir}" && -d "${selected_dir}" ]]; then
    builtin cd "${selected_dir}"
    dev-env
  fi
}

