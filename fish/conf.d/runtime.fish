if test ! -d ~/.runtime
	mkdir ~/.runtime 2> /dev/null
		or echo "Password required to create ~/.runtime"
		and sudo mkdir ~/.runtime
		and sudo chown $USER ~/.runtime
	chmod 0700 ~/.runtime
end
