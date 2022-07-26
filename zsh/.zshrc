#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# zsh-completions configration
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Git
source ${HOME}/.git-completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# Load rbenv
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

# Load nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# alias
alias touchmd='touch $(date +%Y%m%d).md'
alias repo='cd $(ghq list -p | peco --query "$LBUFFER")'
alias merged-repo-delete='git branch --merged|egrep -v "\*|develop|main|master"|xargs git branch -d'

alias gdf='git df'

alias tm='tmux'
alias tns='tm new -s'
alias tat='tm a -t'
alias tls='tm ls'
alias tkil='tm kill-session'
