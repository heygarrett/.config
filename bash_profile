### Custom Terminal prompt
PS1="Vanellope\$PWD $ "

### Set bash to vi mode
set -o vi

### Provide bashmarks functionality
source ~/.local/bin/bashmarks.sh

### Change history format in terminal
export HISTTIMEFORMAT="%d/%m/%y %T "

### Changes to PATH
export PATH="/usr/local/bin:/usr/local/heroku/bin:$PATH:/usr/local/sbin:$HOME/.cabal/bin:/usr/local/share/npm/bin:/usr/local/opt/ruby/bin"
