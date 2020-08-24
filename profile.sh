#
# ~/.profile
# source <<REPO_DIR>>/profile.sh
#

DIR=$(dirname $(readlink -f ${BASH_SOURCE:-$0}))
. $DIR/profile_env

append_paths=$(cat <<-EOF |
    ${HOME}/.local/bin
    ${CARGO_HOME:-${HOME}/.cargo}/bin
EOF
while read -r pth || [ -n "$pth" ];
do
    if [ -d "${pth}" ] && echo ${PATH} | awk -v p=${pth} 'BEGIN { RS=":" } ($0 == p) { exit 1 }';
    then
        printf "$pth:"
    fi
done)
PATH="${append_paths}${PATH}"

$DIR/tmpdisk.sh "${HOME}/tmp"
