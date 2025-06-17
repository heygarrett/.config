function ,update
	brew update && brew upgrade --fetch-HEAD
	hr
	rustup update
	hr
	npm --global update
	hr
	swiftly update --assume-yes
	hr
	pushd $XDG_CONFIG_HOME
	nvim +Update
	popd
end
