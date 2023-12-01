if status is-login
	# environment variables
	set --global --export CARGO_HOME ~/dev/rust/cargo
	set --global --export EDITOR "nvim --cmd 'let g:launched_by_shell=1'"
	set --global --export GHCUP_USE_XDG_DIRS 1
	set --global --export GOPATH ~/dev/go
	set --global --export HOMEBREW_BUNDLE_FILE ~/.config/homebrew/Brewfile
	set --global --export HOMEBREW_NO_ANALYTICS 1
	set --global --export MANPAGER "$EDITOR +Man!"
	set --global --export RUSTUP_HOME ~/dev/rust/rustup
	set --global --export STACK_XDG 1
	set --global --export STARSHIP_CONFIG ~/.config/starship/starship.toml
	set --global --export TEALDEER_CONFIG_DIR ~/.config/tealdeer
	set --global --export XDG_RUNTIME_DIR ~/.runtime

	# PATH
	fish_add_path --global \
		~/.local/bin \
		$GOPATH/bin \
		$CARGO_HOME/bin \
		/opt/homebrew/bin \
		/opt/homebrew/sbin \
		/opt/homebrew/opt/fzf/bin

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
end

# extensions
starship init fish | source
direnv hook fish | source
