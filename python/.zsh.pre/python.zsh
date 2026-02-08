# Poetry (Python package manager) binary default location is ~/.local/bin
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
