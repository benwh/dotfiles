export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# Ensure that we don't source again, if running under tmux
(( SOURCED_PROFILE )) && return
export SOURCED_PROFILE=1

# PATH
PATH="/usr/local/bin:$PATH"
PATH="$HOME/go/bin/:$PATH"
PATH="$HOME/dev/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"
export PATH

if [[ -r "${HOME}/.bashrc" ]]; then
	source "${HOME}/.bashrc"
fi
