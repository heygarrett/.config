#! /bin/sh

/opt/homebrew/bin/tarsnap -c \
	--configfile ~/.config/tarsnap/tarsnap.conf \
	-f "$(uname -n)-$(date +%Y-%m-%d_%H-%M-%S)" \
	/Users/garrett/Library/Mobile\ Documents/com~apple~CloudDocs/Alpha\ System
