function dotfiles
	git --git-dir=$HOME/repos/dotfiles --work-tree=$HOME $argv
end
