# create XDG_RUNTIME_DIR
if test ! -d ~/.runtime
	mkdir ~/.runtime 2>/dev/null
	or echo "Password required to create ~/.runtime"
	and sudo mkdir ~/.runtime
	and sudo chown $USER ~/.runtime
	chmod 0700 ~/.runtime
end

# install wezterm terminfo
if not infocmp wezterm &>/dev/null
	set --local tempfile $(mktemp)
	set --local url $(
		string join "" \
		"https://raw.githubusercontent.com/" \
		"wez/wezterm/master/termwiz/data/wezterm.terminfo"
	)
	curl -o $tempfile $url &>/dev/null
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
end

# set up 1Password ssh agent
set --local op_ssh ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
if test -e "$op_ssh"
	set -x SSH_AUTH_SOCK "$op_ssh"
end

# extensions
starship init fish | source
direnv hook fish | source
