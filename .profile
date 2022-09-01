# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export VISUAL=emacsclient

export EDITOR="$VISUAL"

export NATIVE_FULL_AOT=1
export LSP_USE_PLISTS="true"

export GPG_TTY=$(tty)

if [ -z "$DISPLAY" -a "$(tty)" = '/dev/tty5' ]; then
    exec /usr/bin/startx ~/.xinitrc.exwm >/tmp/startx.log 2>&1
fi
