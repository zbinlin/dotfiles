# GnuPG agent
# Should creating ~/.local/share/gnupg directory before
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null


# XZ
if [ -z "$XZ_OPT" ];
then
    export XZ_OPT='-eT0'
fi


# Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    . /etc/profile.d/vte.sh
fi
