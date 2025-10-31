export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# Ensure that we don't source again, if running under tmux
(( SOURCED_PROFILE )) && return
export SOURCED_PROFILE=1

# TODO: Required?
# source <(kubectl completion bash)

# nvm // node.js // tj/n
export N_PREFIX=$HOME/n

# PATH: ensure that any new entries here are inserted in order of least to most preferred!

PATH="/usr/local/opt/ncurses/bin:$PATH"
# Include /usr/local/bin, but keep it behind Homebrew, as things like Docker for Mac will
# symlink a `kubectl` into here which we don't want.
PATH="/usr/local/bin:$PATH"

if [ -x "$(command -v /opt/homebrew/bin/brew)" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	HOMEBREW_PREFIX=$(brew --prefix)
	# Make all java tools available
	PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

	if [[ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]]; then
		source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
	fi
fi

PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Put user-owned directories most prominently in PATH
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/bin:$PATH"

export PATH

if [[ -r "${HOME}/.bashrc" ]]; then
	source "${HOME}/.bashrc"
fi

# This causes duplicate PATH entries, but the solution is perhaps more unpleasant than the problem.
# https://github.com/rbenv/rbenv/issues/369#issuecomment-22200587
[ -x "$(command -v rbenv)" ] && eval "$(rbenv init -)"
