# GnuPG agent
# Should creating ~/.local/share/gnupg directory before
if command -v gpg-connect-agent >/dev/null;
then
    export GPG_TTY=$(tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null
fi


# XZ
if [ -z "$XZ_OPT" ];
then
    export XZ_OPT='-eT0'
fi


# Tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    . /etc/profile.d/vte.sh
fi
