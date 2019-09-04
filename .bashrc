export TERM=xterm-256color

[ -z "$PS1" ] && return

export LANG=en_US

PS1="[\u@\[\e[36m\]\h\[\e[0m\] \[\e[1;32m\]\w\[\e[0m\]] \[\e[1;37m\]$\[\e[0m\] "

alias rmm='recycle'

recycle() {
    DIR=/tmp/$USER"_recycle"

    if [ ! -d $DIR ]
    then
        mkdir $DIR
    fi
    DIR_NOW=$DIR"/"$(date '+20%y%m%d_%H%M')
    if [ ! -d $DIR_NOW ]
    then
       mkdir $DIR_NOW
    fi

    mv ${1+"$@"} $DIR_NOW
    echo "Recycle "${1+"$@"}" to "$DIR_NOW 
}

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
        *.7z)       ~/tools/p7zip_9.20.1/bin/7za e $1 && cd $(basename "$1" .7z) ;;
#        *.7z)       7z x $1 && cd $(basename "$1" .7z) ;;
        *)      echo "don't know how to extract '$1'..." ;;
    esac
else
    echo "'$1' is not a valid file!"
fi
}

