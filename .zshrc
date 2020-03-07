### Fix path duplication in tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

### Set bash to vi mode
set -o vi

export PATH="$HOME/Users/garrett/homebrew:/Users/garrett/homebrew/bin:/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"
# export PATH="$HOME:/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"

# Preferred editor for local and remote sessions
export EDITOR='nvim'

### Change default prompt
export PS1="[%~]$ "

alias vim="nvim"
alias gist='gist -c'

export PATH=$PATH:$HOME/.yarn/bin

### Fix for conflict between Swift and Homebrew Python 2
### https://forums.swift.org/t/swift-repl-starts-with-error-when-homebrew-python-is-installed/12927
function fix_python() {
    PATH="/usr/bin:$PATH" $*
}

function lldb() {
    fix_python "$(which lldb)" "$@"
}

function swift() {
    fix_python "$(which swift)" "$@"
}
