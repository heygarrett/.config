# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="gallois"

# Disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Stamp shown in the history command output.
HIST_STAMPS="yyyy-mm-dd"

# Load plugins (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git git-extras brew lol osx)

source $ZSH/oh-my-zsh.sh

# User configuration
#
### Fix path duplication in tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

### Set bash to vi mode
set -o vi

export PATH="/Users/Garrett/.cabal/bin:/usr/local/bin:/usr/local/opt/ruby/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
