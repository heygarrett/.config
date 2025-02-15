function git
	set --local index (contains --index -- "--force" $argv)
	if contains push $argv; and test -n "$index"
		set --local prompt "Did you mean --force-with-lease? [Y/n] "
		while read --local --prompt-str $prompt lease; or return 1
			switch $lease
				case y Y ""
					set argv[$index] --force-with-lease
					break
				case n N
					break
			end
		end
		echo git $argv
	end
	command git $argv
end
