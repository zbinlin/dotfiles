# ~/.bashrc or ~/.zshrc
# source <<REPO_DIR>>/rc.sh
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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

[[ -f "${__function_prefix__}rc" ]] && . ${__function_prefix__}rc
[[ -f "${__function_prefix__}.prompt.sh" ]] && . ${__function_prefix__}.prompt.sh

. ${__functions_dir__}/alias.sh
. ${__functions_dir__}/common.rc.sh

unset __shell__
unset __self__
unset __base_dir__
unset __functions_dir__
unset __function_prefix__
