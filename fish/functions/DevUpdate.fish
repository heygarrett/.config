function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	hr
	npm --global update
	hr
	fisher update
	hr
	pushd $HOME/.config
	nvim nvim/plugin/packer.lua \
		"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync"
	popd
end
