starship init fish | source
set -gx GPG_TTY (tty)

if status is-interactive
and not set -q TMUX
	tmux attach || tmux new-session -s G
end
