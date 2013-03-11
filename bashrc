# ~/.bashrc: executed by bash(1) for non-login shells.

# Functions reside in a separate file
source ~/.bashrc.functions

if [ -f /etc/bash_completion ]
then
	source /etc/bash_completion
fi

# Load z, only if running an interactive shell (otherwise scp is cocked up)
[[ $- == *i* ]] && source $HOME/dotfiles/vendor/rupa-z/z.sh

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

if [ "$TERM" = "linux" ]
then
	# we're on the system console or maybe telnetting in
	export PS1="\[\e[32;1m\]\u@\H > \[\e[0m\]"
else
	# we're not on the console, assume an xterm
	bash_prompt
	# Append, because z.sh may have already tampered with PROMPT_COMMAND
	PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history; history -a'
	export TERM='screen-256color'
fi


export LS_OPTIONS='--color=auto'
export GREP_OPTIONS='--color'
export PERL_CPANM_OPT='--sudo '

# http://gophersays.com/from-r60-to-go1/
mygo=$HOME/go
goroot=$HOME/dev/go
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
export PATH=$HOME/bin:$HOME/android-sdk/platform-tools:/usr/local/bin:$PATH
export LESS='-RX'

# Bash history commands
export HISTSIZE=1000 # Keep 1000 lines in session history
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
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

# Enable SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
