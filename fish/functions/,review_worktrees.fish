function ,review_worktrees
	set removal_list
	for wt in $(git worktree list | string split --fields 1 " ")
		echo $wt
		read -fP "Remove? " remove; or return
		if test $remove = y
			set --append removal_list $wt
		end
	end
	set list_count (count $removal_list)
	if test $list_count -eq 0
		return
	end
	echo -e "\nWorktrees to remove:"
	for wt in $removal_list
		echo -e "\t"$wt
	end
	read -fP "Remove worktrees in this list? " remove; or return
	if test $remove = y
		for index in (seq $list_count)
			echo "Removing... ["$index"/"$list_count"]"
			git worktree remove $removal_list[$index]
		end
	end
end
