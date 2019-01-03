### Fix path duplication in tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

### Set bash to vi mode
set -o vi

export PATH="$HOME:/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"

# Preferred editor for local and remote sessions
export EDITOR='nvim'

### Change default prompt
export PS1="[\w]$ "

alias vim="nvim"
alias gist='gist -c'

export PATH=$PATH:$HOME/.yarn/bin

# Go
export GOROOT="/usr/local/opt/go/libexec"
export GOPATH=$HOME/go
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"

# VSCode
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

# AgileBits
alias b5="cd ~/go/src/go.1password.io/b5"
alias b5book="cd ~/go/src/go.1password.io/b5book"
alias mca="make clean all"
alias mcar="make clean && make all run"
alias mcrs="make compile && make run-server"
alias mrs="make run-server"
alias mr="make run"
alias kw="ps -ax | grep -- --watch | awk '{print $1}' | xargs kill -15"
alias rflush="redis-cli flushall"
alias poll="go run tools/b5pollstripeevents/pollstripeevents.go"
export B5_ENV="lcl"
export OP_ENABLE_BETA=true

# Docker
alias dps="docker ps -a"
alias di="docker images"
alias dprune="docker container prune && docker image prune"
alias up="docker-compose up -d"
alias down="docker-compose down"
