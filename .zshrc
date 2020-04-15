### Change default prompt
# export PS1="[%~]$ "

### Trying Pure zsh prompt
# fpath+=$HOME/repos/dotfiles/zsh/pure
# autoload -U promptinit; promptinit
# prompt pure

### Trying zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# zplug (self manage)
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# Pure
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

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
