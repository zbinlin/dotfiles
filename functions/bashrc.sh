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
