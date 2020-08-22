#
# ~/.bashrc
# source <<REPO_DIR>>/bashrc.sh
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 保证改变容器大小时，能够正确换行
shopt -s checkwinsize

# ignore space prefix command in .bash_history
# ignore dups
export HISTCONTROL=ignoreboth:erasedups

export HISTSIZE=8192
export HISTFILESIZE=65536
shopt -s histappend

export HISTTIMEFORMAT="[%F %T] "

DIR=$(dirname $(readlink -f ${BASH_SOURCE:-$0}))
. $DIR/alias.sh
. $DIR/bash_prompt.sh

# GnuPG agent
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

if [ -z "$XZ_OPT" ];
then
    export XZ_OPT='-eT0'
fi
