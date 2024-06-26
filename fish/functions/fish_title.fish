# override default fish_title to change prompt_pwd flags
# also, use long flag names for readability
function fish_title
	# If we're connected via ssh, we print the hostname.
	set --local ssh
	set --query SSH_TTY
	and set ssh "["(prompt_hostname | string sub --length 10 | string collect)"]"
	# An override for the current command is passed as the first parameter.
	# This is used by `fg` to show the true process name, among others.
	if set --query argv[1]
		echo -- $ssh (string sub --length 20 -- $argv[1]) (prompt_pwd --full-length-dirs=2)
	else
		# Don't print "fish" because it's redundant
		set --local command (status current-command)
		if test "$command" = fish
			set command
		end
		echo -- $ssh (string sub --length 20 -- $command) (prompt_pwd --full-length-dirs=2)
	end
end
