# From: https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh
function __find_git_branch__() {
    # Based on: http://stackoverflow.com/a/13003854/170413
    local branch="$(git symbolic-ref --short -q HEAD 2>/dev/null || git name-rev --name-only HEAD 2>/dev/null)"

    if [ -n "$branch" ];
    then
        branch="${branch/\^0/}"
        branch="${branch/\~0/}"
        __git_branch__=" [$branch]"
        if [ -n "$(git status --porcelain 2> /dev/null)" ];
        then
            __git_branch__="${__git_branch__}*"
        fi
    else
        __git_branch__=""
    fi
}

function __set_ps1__() {
    __find_git_branch__

    local default_padding_length=5
    local username_length=${#USER}
    local hostname_length=${#HOSTNAME}
    local pwd=${PWD/#$HOME/\~}
    local pwd_length=${#pwd}

    local    RESET="\[$(tput sgr0    )\]"
    local     BOLD="\[$(tput bold    )\]"
    local NO_COLOR="\[$(tput sgr0    )\]"
    local    BLACK="\[$(tput setaf 0 )\]"
    local   MAROON="\[$(tput setaf 1 )\]"
    local    GREEN="\[$(tput setaf 2 )\]"
    local    OLIVE="\[$(tput setaf 3 )\]"
    local     NAVY="\[$(tput setaf 4 )\]"
    local   PURPLE="\[$(tput setaf 5 )\]"
    local     TEAL="\[$(tput setaf 6 )\]"
    local   SILVER="\[$(tput setaf 7 )\]"
    local     GREY="\[$(tput setaf 8 )\]"
    local      RED="\[$(tput setaf 9 )\]"
    local     LIME="\[$(tput setaf 10)\]"
    local   YELLOW="\[$(tput setaf 11)\]"
    local     BLUE="\[$(tput setaf 12)\]"
    local  FUCHSIA="\[$(tput setaf 13)\]"
    local     AQUA="\[$(tput setaf 14)\]"
    local    WHITE="\[$(tput setaf 15)\]"

    if [ -n "$__git_branch__" ];
    then
        __git_branch__=$(echo "$__git_branch__" | sed "s/\[\(.\+\)\]/${FUCHSIA//\\/\\\\}[${LIME//\\/\\\\}\1${FUCHSIA//\\/\\\\}]/")
        __git_branch__="${__git_branch__/\*/$RED\*}"
    fi
    local git_branch_length=${#__git_branch__}

    local length=$(($default_padding_length + $username_length + $hostname_length + $pwd_length + $git_branch_length))
    local factor
    if [ $COLUMNS -le 80 ];
    then
        factor=2
    elif [ $COLUMNS -le 120 ];
    then
        factor=3
    elif [ $COLUMNS -le 160 ];
    then
        factor=5
    else
        factor=8
    fi
    local max=$(($COLUMNS - $COLUMNS / $factor))

    if [ $length -ge $max ];
    then
        export PS1="${GREY}┌${AQUA}${USER}${GREY}@${AQUA}${HOSTNAME}${WHITE} ${BOLD}${pwd}${RESET}${LIME}${__git_branch__}\n${GREY}└${WHITE}\$${RESET} "
    else
        export PS1="${GREY}›${AQUA}${USER}${GREY}@${AQUA}${HOSTNAME}${WHITE} ${BOLD}${pwd}${RESET}${LIME}${__git_branch__}${WHITE} \$${RESET} "
    fi

    local curpos
    stty -echo
    echo -en '\033[6n'
    IFS=';' read -d R -a curpos
    stty echo
    (( curpos[1] > 1 )) && echo -e '\033[1;35m⮒\033[0m'
}

PROMPT_COMMAND="__set_ps1__; $PROMPT_COMMAND"
