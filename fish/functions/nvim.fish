function nvim
	if not set -q argv[1]
		command nvim "+Load"
	else
		command nvim $argv
	end
end
