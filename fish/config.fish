if not functions -q fisher
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end
starship init fish | source
set -gx GPG_TTY (tty)
