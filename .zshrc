source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

autoload -Uz promptinit
promptinit

autoload -U compinit
compinit -u

autoload -Uz colors
colors

# PATH config ========================================================
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export XDG_CONFIG_HOME="$HOME/.config"

export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

# Load path libffi with Homebrew
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"
export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

eval "$(gh completion -s zsh)"

# ====================================================================

# alias
alias touchmd='touch $(date +%Y%m%d).md'
alias repo='cd $(ghq list -p | peco --query "$LBUFFER")'
alias merged-repo-delete='git branch --merged|egrep -v "\*|develop|main|master"|xargs git branch -d'

# zsh-completions configration
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Git
source ${HOME}/.zsh/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# Load zsh function file

function loadlib() {
        lib=${1:?"You have to specify a library file"}
        if [ -f "$lib" ];then #ファイルの存在を確認
                . "$lib"
        fi
}

loadlib $ZDOTDIR/zshfiles
