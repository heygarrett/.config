function git
	if [ $argv[-1] = "--force" ]
		read -fP "Did you mean --force-with-lease? [y/n]: " lease
		if [ $lease != "n" ]
			set argv[-1] "--force-with-lease"
		end
	end
	command git $argv
end
