### Fix path duplication in tmux
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

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
export PATH=/usr/local/bin:/usr/local/opt/ruby/bin:$PATH:/usr/local/sbin:/Users/Garrett/pebble-dev/PebbleSDK-2.0-BETA7/bin
