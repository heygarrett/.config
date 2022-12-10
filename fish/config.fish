set -gx GPG_TTY (tty)
set --local op_ssh ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
if test -e "$op_ssh"
	set -x SSH_AUTH_SOCK "$op_ssh"
end
starship init fish | source
direnv hook fish | source
