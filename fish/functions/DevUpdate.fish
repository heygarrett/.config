function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	and npm -g update
	and fisher update
	and cd $HOME/.config
	and nvim nvim/plugin/packer.lua \
		"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync"
end
