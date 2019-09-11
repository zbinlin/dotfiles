# From: https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh
__find_git_branch__() {
    # Based on: http://stackoverflow.com/a/13003854/170413
    local branch="$(git symbolic-ref --short -q HEAD 2>/dev/null || git name-rev --name-only HEAD 2>/dev/null)"

    if [ -n "$branch" ];
    then
        branch="${branch/^0/}"
        branch="${branch/~0/}"
        __git_branch__=" [$branch]"
        if [ -n "$(git status --porcelain 2> /dev/null)" ];
        then
            __git_branch__="${__git_branch__}*"
        fi
    else
        __git_branch__=""
    fi
}

__set_ps1__() {
    __find_git_branch__

    local default_padding_length=5
    local username_length=${#USER}
    local hostname_length=${#HOSTNAME}
    local pwd=${PWD/#$HOME/\~}
    local pwd_length=${#pwd}
    local git_branch_length=${#__git_branch__}

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

    local length=$(($default_padding_length + $username_length + $hostname_length + $pwd_length))
    local max=$(($COLUMNS / 3))

    if [ $length -ge $max ];
    then
        export PS1="${GREY}┌${AQUA}${USER}${GREY}@${AQUA}${HOSTNAME}${WHITE} ${BOLD}${pwd}${RESET}${LIME}${__git_branch__}\n${GREY}└${WHITE}\$${NO_COLOR} "
    else
        export PS1="${GREY}›${AQUA}${USER}${GREY}@${AQUA}${HOSTNAME}${WHITE} ${BOLD}${pwd}${RESET}${LIME}${__git_branch__}${WHITE} \$${NO_COLOR} "
    fi
}

PROMPT_COMMAND="__set_ps1__; $PROMPT_COMMAND"
