eval "$(starship init zsh)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit -u
fi

### Set zsh to vi mode
set -o vi

### Default to neovim
# alias vim="nvim"

### Preferred editor for local and remote sessions
export EDITOR="nvim"

### Avoid duplicates in PATH
typeset -U path

### brew bundle
export HOMEBREW_BUNDLE_FILE="$HOME/.Brewfile"
export HOMEBREW_BUNDLE_NO_LOCK=1
