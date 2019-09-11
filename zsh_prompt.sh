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
    local git_branch_length=${#__git_branch__}

    local    RESET="%b%f"
    local     BOLD="%B"
    local NO_COLOR="%f"
    local    BLACK="%F{0}"
    local   MAROON="%F{1}"
    local    GREEN="%F{2}"
    local    OLIVE="%F{3}"
    local     NAVY="%F{4}"
    local   PURPLE="%F{5}"
    local     TEAL="%F{6}"
    local   SILVER="%F{7}"
    local     GREY="%F{8}"
    local      RED="%F{9}"
    local     LIME="%F{10}"
    local   YELLOW="%F{11}"
    local     BLUE="%F{12}"
    local  FUCHSIA="%F{13}"
    local     AQUA="%F{14}"
    local    WHITE="%F{15}"
    local  NEWLINE=$'\n'

    if [ -n "$__git_branch__" ];
    then
        __git_branch__=$(echo "$__git_branch__" | sed "s/\[\(.\+\)\]/${FUCHSIA}[${LIME}\1${FUCHSIA}]/")
        __git_branch__="${__git_branch__/\*/$RED*}"
    fi

    local length=$(($default_padding_length + $username_length + $hostname_length + $pwd_length))
    local max=$(($COLUMNS / 3))

    if [ $length -ge $max ];
    then
        export PS1="${GREY}┌${AQUA}${USER}${GREY}@${AQUA}${HOST}${WHITE} ${BOLD}${pwd}${RESET}${LIME}${__git_branch__}${NEWLINE}${GREY}└${WHITE}\$${RESET} "
    else
        export PS1="${GREY}›${AQUA}${USER}${GREY}@${AQUA}${HOST}${WHITE} ${BOLD}${pwd}${RESET}${LIME}${__git_branch__}${WHITE} \$${RESET} "
    fi
}

PROMPT_COMMAND="__set_ps1__; $PROMPT_COMMAND"

prompt off
prmptcmd() { eval "$PROMPT_COMMAND" }
precmd_functions=(prmptcmd)
