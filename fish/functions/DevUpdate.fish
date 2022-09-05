function DevUpdate
	brew update && brew reinstall neovim && brew upgrade --fetch-HEAD
	hr
	npm --global update
	hr
	fisher update
	hr
	pushd $HOME/.config
	nvim nvim/plugin/packer.lua \
		"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync --preview"
	popd
end
