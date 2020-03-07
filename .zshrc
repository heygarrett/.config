### Fix path duplication in tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

### Set bash to vi mode
set -o vi

export PATH="$HOME:$HOME/homebrew:$HOME/homebrew/bin:/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"
# export PATH="$HOME:/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"

# Preferred editor for local and remote sessions
export EDITOR='nvim'

### Change default prompt
export PS1="[%~]$ "

alias vim="nvim"
alias gist='gist -c'

export PATH=$PATH:$HOME/.yarn/bin

