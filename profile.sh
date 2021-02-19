#
# ~/.profile or ~/.zprofile
# source <<REPO_DIR>>/profile.sh
#

__shell__=$(basename $(readlink /proc/$$/exe))
case ${__shell__} in
    sh | dash | bash)
        __shell__=bash
        __self__=$(readlink -f ${BASH_SOURCE:-$0})
        ;;
    zsh)
        __self__=$(eval 'echo $(readlink -f ${(%):-%x})')
        ;;
    *)
        unset __shell__
        return
        ;;
esac
__base_dir__=$(dirname ${__self__})
__functions_dir__="${__base_dir__}/functions"
__function_prefix__="${__functions_dir__}/${__shell__}"

. ${__functions_dir__}/profile.env

__append_paths__=$(cat <<-EOF |
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
PATH="${__append_paths__}${PATH}"

${__functions_dir__}/tmpdisk.sh "${HOME}/tmp"

unset __shell__
unset __self__
unset __base_dir__
unset __functions_dir__
unset __function_prefix__
unset __append_paths__
