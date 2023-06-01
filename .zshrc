# Load rbenv
export EDITOR=nvim
eval "$(direnv hook zsh)"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(nodenv init -)"
export PATH="$HOME/.nodenv/bin:$PATH"
