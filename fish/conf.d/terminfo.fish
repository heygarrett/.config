if not infocmp wezterm &> /dev/null
	set tempfile $(mktemp)
	curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
		&> /dev/null
	tic -x -o ~/.terminfo $tempfile
	rm $tempfile
end
