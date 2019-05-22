# ~/.bashrc: executed by bash(1) for non-login shells.

# Functions reside in a separate file
# shellcheck source=bashrc.functions
source "${HOME}/.bashrc.functions"

# Brew is slow, so calculate the prefix once
export BREW_PREFIX="/usr/local/opt"
export HOMEBREW_AUTO_UPDATE_SECS="604800" # Update once a week max.

if [[ -x "$(command -v brew)" && -f "$(brew --prefix)/share/bash-completion/bash_completion" ]]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# # Load z, only if running an interactive shell (otherwise scp is cocked up)
# [[ $- == *i* ]] && source $HOME/dotfiles/vendor/rupa-z/z.sh

# Load fasd
if [ -x "$(command -v fasd)" ]; then
  fasd_cd() {
    if [ $# -le 1 ]; then
      fasd "$@"
    else
      local _fasd_ret="$(fasd -e 'printf %s' "$@")"
      [ -z "$_fasd_ret" ] && return
      [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
    fi
  }
  alias z='fasd_cd -d'

  eval "$(fasd --init bash-hook)"
fi

# Vi mode ON!
set -o vi

shopt -s checkwinsize

# Prevent CTRL-s from freezing terminal
# stty doesn't come with msysgit, and isn't required for it
# -t 0 means it only runs if in a terminal
if [ -t 0 ]
then
	if [ $OSTYPE != "msys" ]
	then
		stty stop ''
		stty -ixon
	fi
fi
umask 022

if [ "$TERM" = "linux" ]
then
	# we're on the system console or maybe telnetting in
	export PS1="\[\e[32;1m\]\u@\H > \[\e[0m\]"
else
	# we're not on the console, assume an xterm
	bash_prompt
	#export TERM='screen-256color'
	# TODO: why this no work?
	#export TERM='xterm-kitty'
fi


GREP_OPTIONS='--color'
export PERL_CPANM_OPT='--sudo '
export CLICOLOR=1

if [ -x /usr/bin/dircolors ]
then
	# -b switch is to force bash style output on win32/cygwin
	eval "$(dircolors -b)"
fi

# Aliases
alias mkdir='mkdir -p -v'
alias l='ls -llAh'
alias lsl='ls -lh | less -r'
alias recent="ls -lAt | head"
alias sus="sudo su -"
alias s='sudo'
alias iostat='iostat -x'
alias vmstat='vmstat -S K'
alias pod='perldoc'
alias vless='/usr/share/vim/vimcurrent/macros/less.sh'
alias du1='du -h --max-depth=1'
alias du2='du -h --max-depth=2'
alias du3='du -h --max-depth=3'
alias grep='grep $GREP_OPTIONS'
alias rg='rg --hidden'
alias vim='nvim'
alias view='nvim -R'
alias git-prunebranches='[ "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" == "master" ] && git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

# Kubernetes
alias k='kubectl'
complete -o default -F __start_kubectl k

## Shell varibles
export LS_OPTIONS='--color=auto'
if type nvim > /dev/null; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi
export PAGER=less
export LESS='-RX'

# Bash history commands
export HISTSIZE=10000 # Keep 10000 lines in session history
export HISTFILESIZE=100000 # Truncate file at 100,000 lines
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups,ignorespace
export HISTIGNORE="&:ls:ll:la:l:pwd:exit:clear:gs"
# Don't overwrite history if using multiple bash sessions
shopt -s histappend

# Don't immediately execute command when using history substitution
shopt -s histverify

# Golang stuff
# https://patrickmn.com/software/from-r60-to-go1/
# 'go get' will install in to $HOME/go. My code will live under $HOME/dev/go
GOROOT=$HOME/go
MYGO=$HOME/dev/go
GOBIN=$MYGO/bin:$GOROOT/bin
export GOPATH=$GOROOT:$MYGO

# Bash eternal history:
# http://www.debian-administration.org/articles/543
[[ ! -f $HOME/.bash_eternal_history ]] && (touch $HOME/.bash_eternal_history; chmod 0600 $HOME/.bash_eternal_history)
export HISTTIMEFORMAT="%s "
# Append, because z.sh may have already tampered with PROMPT_COMMAND
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

# Enable SCM Breeze
[ -s "$HOME/dotfiles/vendor/scmbreeze-scm_breeze/scm_breeze.sh" ] && source "$HOME/dotfiles/vendor/scmbreeze-scm_breeze/scm_breeze.sh"


[ -s "$HOME/.autoenv/activate.sh" ] && source "$HOME/.autoenv/activate.sh"
[ -f "${BREW_PREFIX}/autoenv/activate.sh"  ] && source "${BREW_PREFIX}/autoenv/activate.sh"
[ -s "$HOME/src/liquidprompt/liquidprompt" ] && source "$HOME/src/liquidprompt/liquidprompt"

# TODO is there any practical difference between my version (top) and the vendored version (bottom)?
# [ -f "$HOME/.fzf.bash" ] && source "$HOME/.fzf.bash"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# omit --follow, because otherwise it spews errors about broken symlinks all
# over the place (e.g. pruned go dependencies)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 100%'
# why is no-reverse required??
export FZF_CTRL_T_OPTS='--height 100% --no-reverse --bind ctrl-j:down,ctrl-k:up'


# This causes duplicate PATH entries, but the solution is perhaps more unpleasant than the problem.
# https://github.com/rbenv/rbenv/issues/369#issuecomment-22200587
[ -x "$(command -v rbenv)" ] && eval "$(rbenv init -)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion"  ] && . "$NVM_DIR/bash_completion"

#if [ -f "${BREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"  ]; then
#	__GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
#	source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
#fi

export GPG_TTY=$(tty)
alias be='bundle exec'
alias tar=gtar
alias givemedocker='eval $(docker-machine env default)'
alias c="pbcopy"
alias shac="git rev-parse HEAD | tr -d '\\n' | pbcopy"
alias gpf="git push --force-with-lease"
alias smallprompt='unset PROMPT_COMMAND; PS1="> "';
# Sometimes I cat things that I shouldn't
alias resettitle='printf "\e]0;\a"'
alias docker-machine-fix='docker-machine ssh default "sudo mkdir /sys/fs/cgroup/systemd; sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd"'

gh() {
	if git remote > /dev/null; then
		URL=$(git remote -v | head -n1 | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@')
		echo open "$URL"
	fi
}

diffocop() {
	(
		cd "$(git rev-parse --show-toplevel)" && \
			git diff master --name-only --diff-filter=ACMRTUXB \
			| grep '\.rb$' \
			| tr '\n' ' ' \
			| xargs bundle exec rubocop
	)
}

for filename in ~/.bashrc.private*; do
	# This is to ensure we don't break if there's nothing that matches the glob
	[ -e "$filename" ] || continue
	source "$filename"
done
