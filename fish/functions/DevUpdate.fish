function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	and npm -g update
	set -l new
	if test ! -d $HOME/.local/src/lua-language-server
		mkdir -p $HOME/.local/src && cd $HOME/.local/src
		and git clone --depth 1 https://github.com/sumneko/lua-language-server
		and cd lua-language-server && git submodule update --init --recursive
		and set new true
	end
	and cd $HOME/.local/src/lua-language-server && git fetch
	and set -l updates (git log HEAD..origin/master --oneline)
	and if test -n "$updates" -o "$new"
		git merge && git submodule update --recursive
		and pushd 3rd/luamake && compile/install.sh && popd && ./3rd/luamake/luamake rebuild
	end
	and cd $HOME/.config/nvim && nvim lua/config/packer.lua +PackerSync
end
