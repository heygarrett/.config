function ,update
	brew update && brew upgrade --fetch-HEAD
	hr
	npm --global update
	hr
	pushd $HOME/.config
	nvim "+Update"
	popd
end
