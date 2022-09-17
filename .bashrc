# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

# Source the system-wide file.
source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi
alias ls='ls -p --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'

# my settings
gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export VISUAL=emacsclient
export EDITOR="$VISUAL"

export NATIVE_FULL_AOT=1
export LSP_USE_PLISTS="true"

export GPG_TTY=$(tty)

export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin

# for go
export GOPATH=$HOME/projects/go
export PATH=$PATH:$GOPATH/bin

# for ruby
export GEM_HOME=$HOME/.gem
export PATH=$PATH:$GEM_HOME/bin

# for php
export PATH=$PATH:$HOME/.composer/vendor/bin
export COMPOSER_MEMORY_LIMIT=4G

# for rust
export PATH=$PATH:$HOME/.cargo/bin

# for nodejs
export PATH=$PATH:/home/take/.npm-global/bin
