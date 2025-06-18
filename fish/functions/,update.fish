function ,update
	echo \n--Homebrew--
	brew update && brew upgrade --fetch-HEAD

	echo \n--Rust--
	rustup update

	echo \n--npm--
	npm --global update

	echo \n--Swift--
	swiftly update --assume-yes

	pushd $XDG_CONFIG_HOME
	nvim +Update
	popd
end
