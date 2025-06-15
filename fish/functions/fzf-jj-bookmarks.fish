function fzf-jj-bookmarks
	set --local selected_bookmark (
		jj --color=always bookmark list |
		grep --invert-match "^\s\+" |
		fzf --ansi --reverse --height=~100%
	)
	if test -n "$selected_bookmark"
		set --local bookmark_name (string split --max 1 --fields 1 ":" $selected_bookmark)
		commandline --insert $bookmark_name
	end
	commandline --function repaint
end
