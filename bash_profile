if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi


# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

##
# Your previous /Users/andrew/.bash_profile file was backed up as /Users/andrew/.bash_profile.macports-saved_2016-12-05_at_10:57:56
##

# MacPorts Installer addition on 2016-12-05_at_10:57:56: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

