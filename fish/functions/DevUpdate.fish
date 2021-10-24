function DevUpdate
	brew update && brew upgrade && brew cleanup
	and brew upgrade --fetch-HEAD neovim
	and pushd ~/repos/others/lua-language-server 
	and git pull && git submodule update --recursive
	and pushd 3rd/luamake && compile/install.sh && popd && ./3rd/luamake/luamake rebuild
	and popd
end
