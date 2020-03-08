### Set bash to vi mode
set -o vi

### Default to neovim
alias vim="nvim"

### Preferred editor for local and remote sessions
export EDITOR='nvim'

### Avoid duplicates in PATH
typeset -U path

### Change default prompt
export PS1="[%~]$ "

