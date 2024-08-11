export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# Ensure that we don't source again, if running under tmux
(( SOURCED_PROFILE )) && return
export SOURCED_PROFILE=1

if [ -x "$(command -v /opt/homebrew/bin/brew)" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	HOMEBREW_PREFIX=$(brew --prefix)
fi

# TODO - can be removed for intel?
# BREW_PREFIX="/usr/local"

# export BREW_PREFIX="/usr/local"


# TODO: Required?
# source <(kubectl completion bash)

# nvm // node.js // tj/n
export N_PREFIX=$HOME/n

# PATH
if [[ -f "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]]; then
	source "${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi

PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
PATH="/usr/local/opt/ncurses/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/dev/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/n/bin:$PATH"
PATH="$HOME/bin:$PATH"
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH

if [[ -r "${HOME}/.bashrc" ]]; then
	source "${HOME}/.bashrc"
fi

# This causes duplicate PATH entries, but the solution is perhaps more unpleasant than the problem.
# https://github.com/rbenv/rbenv/issues/369#issuecomment-22200587
[ -x "$(command -v rbenv)" ] && eval "$(rbenv init -)"
