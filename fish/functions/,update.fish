function ,update
	brew update && brew upgrade --fetch-HEAD
	hr
	npm --global update
	hr
	fisher update
	hr
	pushd $HOME/.config
	nvim -c "autocmd User VeryLazy ++once Lazy! restore | Lazy! clear | Lazy sync"
	popd
end
