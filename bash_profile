if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

PS1="Vanellope\$PWD $ "

set -o vi

export NODE_PATH="/usr/local/lib/node"
export PATH="$PATH:$HOME/.cabal/bin:/usr/local/share/npm/bin"

source ~/.local/bin/bashmarks.sh

export HISTTIMEFORMAT="%d/%m/%y %T "

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
