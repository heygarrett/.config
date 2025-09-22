function ,update
	echo \n--Homebrew--
	brew update && brew upgrade --fetch-HEAD

	echo \n--Rust--
	rustup update

	echo \n--npm--
	npm --global update

	echo \n--Swift--
	pushd ~
	swiftly update --assume-yes
	popd

	pushd $XDG_CONFIG_HOME
	nvim +Update
	popd
end
