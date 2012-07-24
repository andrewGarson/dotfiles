# .bashrc

# User specific aliases and functions

# Add whatever you want to see after logging in here.

# Specify that ^D won't log you out.
set -o ignoreeof 

# make vi the command-line editor
# comment out to use emacs mode (the default)
set -o vi

# Uncomment to deny `talk' and `write' requests
# mesg n

alias l="ls -CF"
if [[ `uname -s` = "Linux" ]] ; then
	alias ls="ls --color=auto"
fi
alias r="fc -s"
alias h="history"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls -G"
alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# set prompt, though maybe already done in /etc/bashrc
#               see man or info pages for special characters (\u, etc.)
if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
else
  export PS1="\w\n$ "
fi

#use vim
export EDITOR="vim"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
