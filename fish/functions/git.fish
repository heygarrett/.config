function git
	set index (contains --index -- "--force" $argv)
	if contains push $argv; and test -n "$index"
		read -fP "Did you mean --force-with-lease? [Y/n] " lease; or return
		if test "$lease" != n
			set argv[$index] --force-with-lease
		end
	end
	command git $argv
end
