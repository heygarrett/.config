function ,review_worktrees
	for wt in $(git worktree list | string split --fields 1 " ")
		echo $wt
		read -fP "Remove? " remove; or return
		if test "$remove" = y
			git worktree remove "$wt"
		end
	end
end
