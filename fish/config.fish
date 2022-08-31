if not functions -q fisher
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
starship init fish | source
set -gx GPG_TTY (tty)
if test -e ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
	set -x SSH_AUTH_SOCK ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
end
