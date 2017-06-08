### Fix path duplication in tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

### Set bash to vi mode
set -o vi

export PATH="$HOME:/usr/local:/usr/local/bin::/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"

# Preferred editor for local and remote sessions
export EDITOR='nvim'

### Change default prompt
export PS1="[\w]$ "

alias vim="nvim"
alias gist='gist -c'
