# Load rbenv
export EDITOR=nvim
eval "$(direnv hook zsh)"
export FIGMA_API_TOKEN=$(security find-generic-password -a "$USER" -s "FIGMA_API_TOKEN" -w)
