alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias vcfg="nvim --cmd \"cd ~/.config/nvim\" ~/.config/nvim/init.lua ~/.config/nvim/lua/config/colorscheme.lua ~/.config/nvim/lua/config/giogt.lua"

export NVIM_CONFIG_COLORSCHEME="${HOME}/.config/nvim/lua/config/colorscheme.lua"
nvim_colorscheme_light() {
    sd "'colorscheme [^']+'" "'colorscheme dayfox'" ${NVIM_CONFIG_COLORSCHEME}
}
nvim_colorscheme_dark() {
    sd "'colorscheme [^']+'" "'colorscheme duskfox'" ${NVIM_CONFIG_COLORSCHEME}
}

vdev() {
  local selected_dir=$(fd . "${HOME}/dev" -d 3 -a --type directory --exclude .git --exclude node_modules/ --exclude target/ | fzf --preview 'ls -la {}' --height=40% --prompt="📁 ")
  if [[ -n "${selected_dir}" && -d "${selected_dir}" ]]; then
    nvim --cmd "cd ${selected_dir}"
  fi
}
