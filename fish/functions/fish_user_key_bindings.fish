function fish_user_key_bindings
	fish_vi_key_bindings

	bind \ce edit_command_buffer
	bind -M insert \ce edit_command_buffer
	bind -M insert \cf forward-bigword
	bind -M insert \cy accept-autosuggestion
end
