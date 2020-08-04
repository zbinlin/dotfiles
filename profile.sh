#
# ~/.profile
# source <<DIR>>/.dotfiles/profile.sh
#

set -e

append_path="${HOME}/.local/bin"
if [ -d "${append_path}" ] && ! echo ${PATH} | awk -v p=${append_path} 'BEGIN { RS=":"; exists = 1 } ($0 == p) { exists = 0 } END { exit exists }';
then
    PATH="${append_path}:${PATH}"
fi

DIR=$(dirname $(readlink -f ${BASH_SOURCE:-$0}))
. $DIR/env

if command -v tmpdisk >/dev/null 2>&1;
then
    tmpdisk
fi
