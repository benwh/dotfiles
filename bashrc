# ~/.bashrc: executed by bash(1) for non-login shells.

# Functions reside in a separate file
source ~/.bashrc.functions

if [ -f /etc/bash_completion ]
then
	. /etc/bash_completion
	#. ~/.bash_completion_custom
	#complete -F _root_command s
	#complete -C perldoc-complete -o nospace -o default perldoc
	#complete -C perldoc-complete -o nospace -o default pod
	#complete -o bashdefault -o default -o nospace -F _git g
fi

# Vi mode ON!
set -o vi

# Prevent CTRL-s from freezing terminal
# stty doesn't come with msysgit, and isn't required for it
# -t 0 means it only runs if in a terminal
if [ -t 0 ]
then
	if [ $OSTYPE != "msys" ]
	then
		stty stop ''
	fi
fi
umask 022

export LS_OPTIONS='--color=auto'
export GREP_OPTIONS='--color'
export PERL_CPANM_OPT='--sudo '

# http://gophersays.com/from-r60-to-go1/
mygo=/home/ben/go
goroot=/home/ben/dev/go
gobin=$goroot/bin:$mygo/bin
export GOPATH=$goroot:$mygo
export PATH=$PATH:$gobin

if [ -x /usr/bin/dircolors ]
then
	# -b switch is to force bash style output on win32/cygwin
	eval "`dircolors -b`"
fi

# Aliases
alias mkdir='mkdir -p -v'
alias ls='ls $LS_OPTIONS'
alias l='ls $LS_OPTIONS -llAh'
alias lsl='ls -lh --color=always | less -r'
alias recent="ls -lAt | head"
alias sr="screen -aAr"
alias scr="screen"
alias sus="sudo su -"
alias s='sudo'
alias iostat='iostat -x'
alias vmstat='vmstat -S K'
alias pod='perldoc'
alias vless='/usr/share/vim/vimcurrent/macros/less.sh'
alias du1='du -h --max-depth=1'
alias du2='du -h --max-depth=2'
alias du3='du -h --max-depth=3'
alias pacman='pacman-color'

## Shell varibles
export LS_OPTIONS='--color=auto'
export EDITOR=vim
export PAGER=less
export PATH=$HOME/bin:$HOME/go/bin:/home/ben/android-sdk/platform-tools:/usr/local/bin:$PATH
export LESS='-RX'

# Bash history commands
export HISTSIZE=500000 # Record last 500,000 commands
export HISTFILESIZE=100000 # Record 100,000 commands per session
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups,ignorespace
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear"
# Don't overwrite history if using multiple bash sessions
shopt -s histappend


if [ "$TERM" = "linux" ]
then
	# we're on the system console or maybe telnetting in
	export PS1="\[\e[32;1m\]\u@\H > \[\e[0m\]"
else
	# we're not on the console, assume an xterm
	bash_prompt
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
	export TERM='screen-256color'
fi

# Enable autojump
if [ -x /etc/profile.d/autojump.bash ]
then
    source /etc/profile.d/autojump.bash
fi

# Enable SCM Breeze
[ -s "/home/ben/.scm_breeze/scm_breeze.sh" ] && source "/home/ben/.scm_breeze/scm_breeze.sh"
