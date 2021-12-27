function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	and npm -g update
	and cd $HOME/.config/nvim && nvim lua/config/packer.lua +PackerSync
end
