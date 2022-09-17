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
