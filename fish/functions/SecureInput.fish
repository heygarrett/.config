function SecureInput
	set current_status ""
	while true
		set sid (ioreg -l -w 0 | grep SecureInput)
		if test "$sid" != "" -a "$current_status" != "Active"
			set current_status "Active"
			echo "$current_status"
		else if test "$sid" = "" -a "$current_status" != "Inactive"
			set current_status "Inactive"
			echo "$current_status"
		end
	end
end
