export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# Ensure that we don't source again, if running under tmux
(( SOURCED_PROFILE )) && return
export SOURCED_PROFILE=1

BREW_PREFIX="/usr/local"

export BREW_PREFIX="/usr/local"
if [[ -f "${BREW_PREFIX}/share/bash-completion/bash_completion" ]]; then
	source "${BREW_PREFIX}/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# nvm // node.js // tj/n
export N_PREFIX=$HOME/n

# PATH
if [[ -f "${BREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]]; then
	source "${BREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"
fi
PATH="/usr/local/opt/ncurses/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/go/bin/:$PATH"
PATH="$HOME/dev/go/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/n/bin:$PATH"
PATH="$HOME/bin:$PATH"

export PATH

if [[ -r "${HOME}/.bashrc" ]]; then
	source "${HOME}/.bashrc"
fi

# This causes duplicate PATH entries, but the solution is perhaps more unpleasant than the problem.
# https://github.com/rbenv/rbenv/issues/369#issuecomment-22200587
[ -x "$(command -v rbenv)" ] && eval "$(rbenv init -)"
