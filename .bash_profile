# .bash_profile
####################################
# Get the aliases and functions
####################################
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
################################################
# User specific environment and startup programs
################################################



#########################################################################
# Common settings for all host
if [ -f ~/.bash_profile_common ]; then
	. ~/.bash_profile_common
fi

# Specific settings for your built libraries at particular host
#if [ -f ~/$LOCAL_BASH_FILE ]; then
#	. ~/$LOCAL_BASH_FILE
#fi

