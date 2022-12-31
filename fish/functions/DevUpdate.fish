function DevUpdate
	brew update && brew upgrade --fetch-HEAD
	hr
	npm --global update
	hr
	fisher update
	hr
	pushd $HOME/.config
	nvim -c "autocmd User VeryLazy Lazy sync" nvim/lua/plugins
	popd
end
