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
alias ...="cd ../.."
alias ....="cd ../../.."
alias eucassh="ruby ~/chef/euca_ssh.rb"
alias euca_scp_secret="ruby ~/chef/euca_scp_secret.rb"
alias b="bundle exec"

# set prompt, though maybe already done in /etc/bashrc
#               see man or info pages for special characters (\u, etc.)
if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
else
  export PS1="\w\n$ "
fi

#use vim
export EDITOR="vim"

# Perforce BS
export P4PORT=tcp:perflax01:1666
export P4CHARSET=utf8

# Setup rbenv
export PATH="$PATH:$HOME/.rbenv/bin"
eval "$(rbenv init -)"
export ANDROID_HOME=/Users/andrew/development/android-sdk-macosx/
export PATH=/Users/andrew/development/android-sdk-macosx/tools:$PATH

# Setup GO installed by Homebrew
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/opt/go/libexec"

preexec () { 
  if [ -d "$1" ]; then
    cd $1
    return 0;
  else
    :;
  fi
}
preexec_invoke_exec () {
  [ -n "$COMP_LINE" ] && return  # do nothing if completing
  [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
  local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
  preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG

export PATH="$HOME/.node/bin:$PATH"

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/andrew/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
