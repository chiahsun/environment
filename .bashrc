# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# For better looking
# ref: http://mike.bailey.net.au/2011/02/making-vim-look-like-textmate-again/
export TERM=xterm-256color

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
export LANG=en_US
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8
#export LANG=zh_TW.UTF-8

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

PS1="[\u@\[\e[36m\]\h\[\e[0m\] \[\e[1;32m\]\w\[\e[0m\]] \[\e[1;37m\]$\[\e[0m\] "
# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
	*)
	;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
#if [ "$TERM" != "dumb" ]; then
	#eval "`dircolors -b`"
	#alias ls='ls --color=auto'
	#alias dir='ls --color=auto --format=vertical'
	#alias vdir='ls --color=auto --format=long'
#fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

alias aptinstall='sudo apt-get install'
alias aptsearch='sudo apt-cache search'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi


#test if a file should be opened normally, or as root (vi)
argc () {
	count=0;
	for arg in "$@"; do
		if [[ ! "$arg" =~ '-' ]]; then count=$(($count+1)); fi;
		done;
		echo $count;
	}

	vi () { if [[ `argc "$@"` > 1 ]]; then /usr/bin/vim $@;
	elif [ $1 = '' ]; then /usr/bin/vim;
	elif [ ! -f $1 ] || [ -w $1 ]; then /usr/bin/vim $@;
	else
		echo -n "File is readonly. Edit as root? (Y/n): "
		read -n 1 yn; echo;
		if [ "$yn" = 'n' ] || [ "$yn" = 'N' ];
		then /usr/bin/vim $*;
		else sudo /usr/bin/vim $*;
		fi
	fi
}

function my_ip() # get IP adresses
{
	MY_IP=$(/sbin/ifconfig eth0 | awk "/inet/ { print $2 } " | sed -e s/addr://)
	MY_ISP=$(/sbin/ifconfig eth0 | awk "/P-t-P/ { print $3 } " | sed -e s/P-t-P://)
}

function ii() # get current host related info
{
	echo -e "\nYou are logged on ${RED}$HOST"
	echo -e "\nAdditionnal information:$NC " ; uname -a
	echo -e "\n${RED}Users logged on:$NC " ; w -h
	echo -e "\n${RED}Current date :$NC " ; date
	echo -e "\n${RED}Machine stats :$NC " ; uptime
	echo -e "\n${RED}Memory stats :$NC " ; free
#	my_ip 2>&. ;
#	echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:."Not connected"}
#	echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:."Not connected"}
#	echo
}

untar () {
if [ -f $1 ] ; then
    case $1 in
        *.tar.bz2)  tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
        *.tar.Z)    tar xvzf $1 && cd $(basename "$1" .tar.Z) ;;
        *.tar.gz)   tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
        *.tar.xz)   tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
        *.bz2)      bunzip2 $1 && cd $(basename "$1" /bz2) ;;
        *.rar)      unrar x $1 && cd $(basename "$1" .rar) ;;
        #*.gz)       gunzip $1 && cd $(basename "$1" .gz) ;; zxvf
        *.gz)       tar zxvf $1 && cd $(basename "$1" .gz) ;;
        *.tar)      tar xvf $1 && cd $(basename "$1" .tar) ;;
        *.tbz2)     tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
        *.tgz)      tar xvzf $1 && cd $(basename "$1" .tgz) ;;
        *.zip)      unzip $1 && cd $(basename "$1" .zip) ;;
        *.Z)        uncompress $1 && cd $(basename "$1" .Z) ;;
        *.7z)       /home/chiahsun/tools/p7zip_9.20.1/bin/7za e $1 && cd $(basename "$1" .7z) ;;
#        *.7z)       7z x $1 && cd $(basename "$1" .7z) ;;
        *)      echo "don't know how to extract '$1'..." ;;
    esac
else
    echo "'$1' is not a valid file!"
fi
}

################################################################################
# Executes command with a timeout
# Params:
#   $1 timeout in seconds
#   $2 command
# Returns 1 if timed out 0 otherwise
timeout() {

    time=$1

    # start the command in a subshell to avoid problem with pipes
    # (spawn accepts one command)
    #command="/bin/sh -c \"$2\" "
    command="/bin/sh -c \"$2\""

    expect -c "set echo \"-noecho\"; set timeout $time; spawn -noecho $command; expect timeout { exit 1 } eof { exit 0 }"    
    #expect -c "set echo \"-noecho\"; set timeout $time; spawn -noecho $command; expect timeout { exit 1 } eof { exit 0 }"    
    #expect -c "set timeout $time; spawn $command; expect timeout { exit 1 } eof { exit 0 }"    

    if [ $? = 1 ] ; then
        echo "Timeout after ${time} seconds"
    fi

}

################################################################################
# Tarball a directory to a file with time suffix
# Params:
#   $1 Directory name 
tart() {
    DIR="$1"
    if [ $# -ne 1 ]
    then 
	    echo "Usage: $0 {dir_name}"
	    exit 1
    fi

    if [ -d "$DIR" ] 
        then 
    	echo $DIR
    else
        echo "Error: Directory '$DIR' not exsited!"
	    exit 1
    fi
    FILE_NAME_SUFFUX=$(date '+20%y%m%d_%H%M%S')

    lastchr=${DIR#${DIR%?}}
    S0=$DIR
    S1="${DIR%?}"

    echo $FILE_NAME
    if [ "$lastchr" = "/" ]
    then
        FILE_NAME=$S1"_"$FILE_NAME_SUFFUX
    else
        FILE_NAME=$S0"_"$FILE_NAME_SUFFUX
    fi

    FILE_NAME=$FILE_NAME".tar.gz"
    echo $FILE_NAME
    tar zcvf "$FILE_NAME" "$DIR"
}
tartd() {
    DIR="$1"
    if [ $# -ne 1 ]
    then 
	    echo "Usage: $0 {dir_name}"
	    exit 1
    fi

    if [ -d "$DIR" ] 
        then 
    	echo $DIR
    else
        echo "Error: Directory '$DIR' not exsited!"
	    exit 1
    fi
    FILE_NAME_SUFFUX=$(date '+20%y%m%d_%H%M%S')

    lastchr=${DIR#${DIR%?}}
    S0=$DIR
    S1="${DIR%?}"

    echo $FILE_NAME
    if [ "$lastchr" = "/" ]
    then
        FILE_NAME=$S1"_"$FILE_NAME_SUFFUX
    else
        FILE_NAME=$S0"_"$FILE_NAME_SUFFUX
    fi

    FILE_NAME=$FILE_NAME".tar.gz"
    echo $FILE_NAME
    tar zcvf "$FILE_NAME" "$DIR"
    rm -rf "$DIR"    
}


recycle() {
	DIR=/tmp/chiahsun_recycle
	if [ ! -d $DIR ]
	then
		mkdir $DIR 
	fi
    DIR_TODAY=$DIR"/"$(date '+20%y%m%d_%H%')
	if [ ! -d $DIR_TODAY ]
	then
		mkdir $DIR_TODAY 
	fi

	mv ${1+"$@"} $DIR_TODAY 
}

clear
#echo -e "${LIGHTGRAY}";figlet "Laptop Term";
echo ""
echo -ne "${red}Today is:\t\t${cyan}" `date`; echo ""
echo -e "${red}Kernel Information: \t${cyan}" `uname -smr`
#echo -ne "${cyan}";upinfo;echo ""
#echo -e "${cyan}"; cal -3
echo ""

alias rmm='recycle'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -GF' 

 #alias vim='/home/chiahsun/tools/build/hebe/gnu_versions/path/bin/vim -X'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# for tmux auto renaming
PROMPT_COMMAND='echo -ne "\033]0;\007"'

echo "TMUX SIMPLE COMMANDS"
echo "tmux mouse copy : shift + mouse"
echo "tmux page-up : ctrl + shift + up"
echo "tmux detach : ctrl + a + d"
echo "tmux usage : "
echo "   tmux new -s session-name"
echo "   tmux attach -t session"
echo "   tmux ls"
