function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	and npm -g update
	and fisher update
	and cd $HOME/.config/nvim
	and nvim plugin/packer.lua \
	"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync"
end
