function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	and npm -g update
	and cd $HOME/.config/nvim
	and nvim lua/config/packer.lua \
	"+PackerSnapshotDelete latest" "+PackerSnapshot latest" "+PackerSync"
end
