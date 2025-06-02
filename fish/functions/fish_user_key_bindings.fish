function fish_user_key_bindings
	fish_vi_key_bindings

	bind --mode insert \cb fzf-jj-bookmarks
	bind \ce edit_command_buffer
	bind --mode insert \ce edit_command_buffer
	bind --mode insert \cf forward-bigword
	bind --mode insert \cy accept-autosuggestion
end
