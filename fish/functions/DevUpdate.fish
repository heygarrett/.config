function DevUpdate
	pushd $HOME/.config
	git fetch && git rebase origin/main
	brew update && brew upgrade --fetch-HEAD
	npm --global update
	fisher update
	nvim nvim/plugin/packer.lua \
		"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync"
	popd
end
