# ~/.bashrc: executed by bash(1) for non-login shells.

# Functions reside in a separate file
# shellcheck source=bashrc.functions
source "${HOME}/.bashrc.functions"

# Brew is slow, so calculate the prefix once
export HOMEBREW_AUTO_UPDATE_SECS="604800" # Update once a week max.
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha
export HOMEBREW_NO_ANALYTICS=1

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
	bash_prompt # from bashrc.functions
	#export TERM='screen-256color'
	# TODO: why this no work?
	#export TERM='xterm-kitty'
fi

if [[ -f "${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh" ]]; then
	source "${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh"
fi

if [[ -f "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
	source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

if [[ -f "${HOMEBREW_PREFIX}/opt/asdf/etc/bash_completion.d/asdf.bash" ]]; then
	source "${HOMEBREW_PREFIX}/opt/asdf/etc/bash_completion.d/asdf.bash"
fi

if [[ -r "${HOME}/dotfiles/kubectl_aliases" ]]; then
	source "${HOME}/dotfiles/kubectl_aliases"
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
alias ag="ag --hidden"
alias killsshmux="pkill -f ssh:"
alias be='bundle exec'
alias bi='bundle install'
alias smallprompt='unset PROMPT_COMMAND; PS1="> "';
alias resettitle='printf "\e]0;\a"' # Sometimes I cat things that I shouldn't
alias splits='ts -s "%.S"'
alias times='ts "%H:%M:%.S"'
alias gipr='github-open-pr'
alias tmux-restore='tmux new -s restore ~/dotfiles/tmux/plugins/tmux-resurrect/scripts/restore.sh'
alias epochtime='date "+%s"'

# Kubernetes
alias k='kubectl'
complete -o default -F __start_kubectl k
# TODO: Remove after 1.26
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Alias g to git, keep completions
alias g='git'
__git_complete g __git_main

# Git aliases
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gcm="git commit --amend"
alias gcmh="git commit --amend -C HEAD"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcv="git commit --verbose"
alias gd="git diff"
alias gdc="git diff --cached"
alias git-prunebranches='[ "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" == "master" ] || (echo "Not on master"; exit 1) && git branch --merged master | grep -v "\* master" | xargs -n 1 echo git branch -d'
alias gl="git log"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grm="git rm"
alias grs="git reset"
alias shac="git rev-parse HEAD | tr -d '\\n' | pbcopy"


# macOS-specific things
if type gtar > /dev/null 2>&1; then
	alias tar=gtar
fi
alias c="pbcopy"
alias docker-machine-fix='docker-machine ssh default "sudo mkdir /sys/fs/cgroup/systemd; sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd"'
alias givemedocker='eval $(docker-machine env default)'

## Shell variables
export LS_OPTIONS='--color=auto'
if type nvim > /dev/null 2>&1; then
	export EDITOR=nvim
	alias vim='nvim'
	alias view='nvim -R'
	alias vimdiff='nvim -d'
else
	export EDITOR=vim
fi
export PAGER=less
export LESS='-RX'
export GPG_TTY=$(tty)

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

# Bash eternal history:
# http://www.debian-administration.org/articles/543
[[ ! -f $HOME/.bash_eternal_history ]] && (touch $HOME/.bash_eternal_history; chmod 0600 $HOME/.bash_eternal_history)
export HISTTIMEFORMAT="%s "

# We're about to append our eternal history command to PROMPT_COMMAND, but
# other things may have tampered with PROMPT_COMMAND before this point.
# To address this, ensure that we separate with a semicolon, but only if there
# isn't one already present.
if [ -n "$PROMPT_COMMAND" ] && [[ ! "$PROMPT_COMMAND" =~ \;\s*$ ]]; then
	PROMPT_COMMAND="${PROMPT_COMMAND};"
fi

# Format: BASH_PID USER HIST_NUMBER TIMESTAMP COMMAND
PROMPT_COMMAND=$PROMPT_COMMAND'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

# Load scmpuff if enabled, for numbered git shortcuts
if [ -x "$(command -v scmpuff)" ]; then
	eval "$(scmpuff init -s)"
fi

if [ -x "$(command -v direnv)" ]; then
	eval "$(direnv hook bash)"
fi

if [ -x "$(command -v fnm)" ]; then
	eval "$(fnm env --use-on-cd)"
fi

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

# Override the default history function with one that looks at .bash_eternal_history instead
# This should be kept up to date with the upstream version: https://github.com/junegunn/fzf/blob/master/shell/key-bindings.bash
__fzf_history__() {
	local output
	output=$(

	# Original code:
		# builtin fc -lnr -2147483648 |
			# last_hist=$(HISTTIMEFORMAT='' builtin history 1) perl -n -l0 -e 'BEGIN { getc; $/ = "\n\t"; $HISTCMD = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCMD - $. . "\t$_" if !$seen{$_}++' |

		# Maybe todo: de-dupe?
		tac ~/.bash_eternal_history | uniq |
			FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) --query "$READLINE_LINE" |
			perl -pe 's/^[0-9]+\s+[a-z]+\s+[0-9]+\s+[0-9]{10}\s+//'
	) || return
	READLINE_LINE=${output#*$'\t'}
	if [ -z "$READLINE_POINT" ]; then
		echo "$READLINE_LINE"
	else
		READLINE_POINT=0x7fffffff
	fi
}

# https://github.com/junegunn/fzf/wiki/examples#git
fzbr() {
	local branches branch
	branches=$(
		git for-each-ref --sort=committerdate --format='%(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) %(color:reset)' \
		| sed "s#origin/##"| uniq | grep -v HEAD) && branch=$(echo "$branches" | fzf +m) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fzasdfi() {
	local lang=${1}

	if [[ ! $lang ]]; then
		lang=$(asdf plugin-list | fzf)
	fi

	if [[ $lang ]]; then
		local versions=$(asdf list-all $lang | fzf -m)
		if [[ $versions ]]; then
			for version in $(echo $versions); do
				asdf install $lang $version
			done;
		fi
	fi
}

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion"  ] && . "$NVM_DIR/bash_completion"

#if [ -f "${BREW_PREFIX}/opt/bash-git-prompt/share/gitprompt.sh"  ]; then
#	__GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
#	source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
#fi

ghbrowse() {
	if git remote > /dev/null; then
		URL=$(git remote -v | head -n1 | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@')
		open "$URL"
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

if [ -x "$(command -v starship)" ]; then
    # Nice terminal window titles, when within tmux too.
    function set_win_title(){
        echo -ne "\033]0; $PWD \007"
    }

    # shellcheck disable=SC2034
    starship_precmd_user_func="set_win_title"
    eval "$(starship init bash)"
fi
