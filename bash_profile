### Custom Terminal prompt
PS1="Vanellope\$PWD $ "

### Set bash to vi mode
set -o vi

### Provide bashmarks functionality
source ~/.local/bin/bashmarks.sh

### Change history format in terminal
export HISTTIMEFORMAT="%d/%m/%y %T "

### Set solarized background color
colorize

### Changes to PATH
export PATH="/usr/local/bin:$PATH:/usr/local/sbin"
