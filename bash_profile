if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

source ~/.euca/eucarc

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
