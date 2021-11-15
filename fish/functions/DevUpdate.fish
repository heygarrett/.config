function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	and npm -g update
	and cd $HOME/.local/src/lua-language-server && git fetch
	and set -l updates (git log HEAD..origin/master --oneline)
	and if test -n "$updates"
		git merge && git submodule update --recursive
		and pushd 3rd/luamake && compile/install.sh && popd && ./3rd/luamake/luamake rebuild
	end
	and cd $HOME/.config/nvim && nvim lua/config/packer.lua +PackerSync
end
