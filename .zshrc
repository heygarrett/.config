### Set bash to vi mode
set -o vi

typeset -U path
path=(~/homebrew ~/homebrew/bin $path)

# Preferred editor for local and remote sessions
export EDITOR='nvim'

### Change default prompt
export PS1="[%~]$ "

alias vim="nvim"

