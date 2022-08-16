function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	npm --global update
	fisher update
	pushd $HOME/.config
	nvim nvim/plugin/packer.lua \
		"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync"
	popd
end
