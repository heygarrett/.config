eval "$(starship init zsh)"

### Set zsh to vi mode
set -o vi

### Default to neovim
alias vim="nvim"

### Preferred editor for local and remote sessions
export EDITOR="nvim"

### Avoid duplicates in PATH
typeset -U path

### brew bundle
export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"
export HOMEBREW_BUNDLE_NO_LOCK=1
