# XDG base directory spec
set --global --export XDG_CACHE_HOME "$HOME"/.cache
set --global --export XDG_CONFIG_HOME "$HOME"/.config
set --global --export XDG_DATA_HOME "$HOME"/.local/share
set --global --export XDG_RUNTIME_DIR $TMPDIR
set --global --export XDG_STATE_HOME "$HOME"/.local/state

# environment variables
set --global --export CARGO_HOME "$XDG_DATA_HOME"/cargo
set --global --export DIRENV_WARN_TIMEOUT 0
set --global --export EDITOR env ENV_EDITOR=1 nvim
set --global --export GHCUP_USE_XDG_DIRS 1
set --global --export GOPATH "$XDG_DATA_HOME"/go
set --global --export HOMEBREW_BUNDLE_FILE "$XDG_CONFIG_HOME"/homebrew/Brewfile
set --global --export HOMEBREW_NO_ANALYTICS 1
set --global --export MANPAGER $EDITOR +Man!
set --global --export MISE_FISH_AUTO_ACTIVATE 0
set --global --export NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME"/npm/npmrc
set --global --export RUSTUP_HOME "$XDG_DATA_HOME"/rustup
set --global --export SSH_AUTH_SOCK \
	"$HOME"/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
set --global --export STACK_XDG 1
set --global --export STARSHIP_CONFIG "$XDG_CONFIG_HOME"/starship/starship.toml
set --global --export SWIFTLY_HOME_DIR "$XDG_DATA_HOME"/swiftly
set --global --export SWIFTLY_BIN_DIR "$SWIFTLY_HOME_DIR"/bin
set --global --export TAB_WIDTH 4
set --global --export TEALDEER_CONFIG_DIR "$XDG_CONFIG_HOME"/tealdeer
set --global --export TERMINFO "$XDG_DATA_HOME"/terminfo
set --global --export TERMINFO_DIRS $TERMINFO /usr/share/terminfo
set --global --export VISUAL $EDITOR

if status is-login
	# PATH
	fish_add_path --global \
		"$HOME"/.local/bin \
		"$GOPATH"/bin \
		"$CARGO_HOME"/bin \
		$SWIFTLY_BIN_DIR \
		/opt/homebrew/bin \
		/opt/homebrew/sbin \
		/opt/homebrew/opt/rustup/bin
end

if status is-interactive
	# settings
	set --global fish_cursor_insert line
	set --global fish_vi_force_cursor true
	tabs -"$TAB_WIDTH"

	# install wezterm terminfo
	if not infocmp wezterm &>/dev/null
		set --local tempfile (mktemp)
		set --local url (
			string join "" \
				"https://raw.githubusercontent.com/" \
				"wez/wezterm/master/termwiz/data/wezterm.terminfo"
		)
		curl $url --output $tempfile &>/dev/null
		tic -x $tempfile
		rm $tempfile
	end

	# extensions
	set --local op_plugins "$XDG_CONFIG_HOME"/op/plugins.sh
	if test -r "$op_plugins"
		source $op_plugins
	end
	starship init fish | source
	direnv hook fish | source
	fzf --fish | source
	mise activate fish | source
end
