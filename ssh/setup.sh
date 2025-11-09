#!/bin/sh

if [ -e ~/.ssh/config ]; then
	echo "SSH config found. Skipping symlink."
else
	echo "No SSH config found. Linking..."
	ln -s ~/.config/ssh/config ~/.ssh/config
fi

if [ -e ~/.ssh/id_ed25519 ]; then
	echo "SSH key found. Skipping key generation."
else
	echo "No SSH key found. Generating key..."
	ssh-keygen -t ed25519 -C "garrett@iusevimbtw.com"
fi
