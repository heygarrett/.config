function DevUpdate
	brew update && brew upgrade && brew cleanup
	and brew upgrade --fetch-HEAD neovim
	and cd $HOME/.local/src/lua-language-server && git fetch
	and set -l updates (git log HEAD..origin/master --oneline)
	and if updates != ''
		git merge && git submodule update --recursive
		and pushd 3rd/luamake && compile/install.sh && popd && ./3rd/luamake/luamake rebuild
	end
	and cd $HOME/.config/nvim && nvim lua/plugins/packer.lua +PackerSync
end
