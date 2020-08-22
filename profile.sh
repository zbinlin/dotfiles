#
# ~/.profile
# source <<REPO_DIR>>/profile.sh
#

set -e

append_path="${HOME}/.local/bin"
if [ -d "${append_path}" ] && ! echo ${PATH} | awk -v p=${append_path} 'BEGIN { RS=":"; exists = 1 } ($0 == p) { exists = 0 } END { exit exists }';
then
    PATH="${append_path}:${PATH}"
fi

DIR=$(dirname $(readlink -f ${BASH_SOURCE:-$0}))
. $DIR/profile_env

$DIR/tmpdisk.sh "${HOME}/tmp"
