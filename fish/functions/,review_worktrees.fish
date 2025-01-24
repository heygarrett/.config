function ,review_worktrees
	set --local removal_list
	for wt in $(git worktree list | string split --fields 1 " ")
		echo $wt
		while read --local --prompt-str "Remove? [y/n] " remove; or return 1
			switch $remove
				case y Y
					set --append removal_list $wt
					break
				case n N
					break
			end
		end
	end
	set --local list_count (count $removal_list)
	if test "$list_count" -eq 0
		return
	end
	echo -e "\nWorktrees to remove:"
	for wt in $removal_list
		echo -e "\t"$wt
	end
	set --local prompt "Remove worktrees in this list? [y/n] "
	while read --local --prompt-str $prompt remove; or return 1
		switch $remove
			case y Y
				for index in (seq $list_count)
					echo "Removing... ["$index"/"$list_count"]"
					git worktree remove $removal_list[$index]
				end
				break
			case n N
				break
		end
	end
	while read --local --prompt-str "Run nix-collect-garbage? [y/n] " nix_garbage; or return 1
		switch $nix_garbage
			case y Y
				nix-collect-garbage
				break
			case n N
				break
		end
	end
end
