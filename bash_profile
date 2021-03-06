#!/bin/bash

# DEPRECATED! Note: This file has been superseded by `zshrc`
#
# 88888b.  8888888 88888b.  88888b.  8888888 .d888b.        d88 88888888 8888888 88888b.
# 88  "Y8b 88      88   Y8b 88   Y8b 88     d88P  Y8b      d888    88    88      88  "Y8b
# 88    88 88      88    88 88    88 88     888    88     d8P88    88    88      88    88
# 88    88 88888   88   d8P 88   d8P 88888  888          d8P 88    88    88888   88    88
# 88    88 88      88888P"  88888P"  88     888         d8P  88    88    88      88    88
# 88    88 88      88       88 T8b   88     888    88  d8P   88    88    88      88    88
# 88  .d8P 88      88       88  T8b  88     Y88b  d8P d88888888    88    88      88  .d8P
# 88888P"  8888888 88       88   T8b 8888888 "Y888P" d8P     88    88    8888888 88888P"


# sudobin is Marcos' way of not just letting homebrew override any old system binary
# Setup:
#     sudo mkdir /usr/local/sudobin && sudo chmod 755 /usr/local/sudobin && sudo -k
export PATH=/usr/local/sudobin:$PATH
if [ -d "$HOME/.chefdk" ]; then
  # chefdk
  export PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH
fi
# link homebrew sbins
export PATH=$PATH:/usr/local/sbin
# go-installed binaries
export PATH=$PATH:/usr/local/gocode/bin

#export PATH=/usr/local/bin:$PATH


# Helpers
alias ll="ls -l"
baconipsum() {
  local numParas="$1"
  if [[ "$numParas" =~ ^--?h ]]; then
    echo "Usage: baconipsum [<num-paragraphs>] | --help"; return 0
  elif [ -z "$numParas" ]; then
    numParas=1
  fi
  if [[ ! "$numParas" =~ ^[0-9]+$ ]]; then
    echo "Error: The first argument must be a number" >&2; return 3
  fi
  curl -sS "https://baconipsum.com/api/?type=meat-and-filler&start-with-lorem=1&paras=$numParas" >&1 | jq -r 'join("\n\n")'
}

# Configure the prompt with Starship
# via `brew install starship`
command -v starship >/dev/null && eval "$(starship init bash)"

# Import my custom .bash_scripts
[[ -f ~/.bash_scripts/keys.sh ]] && source ~/.bash_scripts/keys.sh

# Docker
alias doco='docker-compose'

# foreman
alias fm="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES forego"
alias fms="fm start"

# git
alias gsu="git submodule update"
alias gdm="git diff | mate"

# Go
export GOPATH=/usr/local/gocode

# rvm and/or rbenv
if [[ -d "$HOME/.rvm" ]]; then
  # Load RVM into a shell session *as a function*
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
elif which rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
# auto-nvm on cd (via https://stackoverflow.com/a/48322289/5539 )
nvm_enter_directory() {
  if [[ $PWD == $NVM_PREV_PWD ]]; then
    return
  fi

  NVM_PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use > /dev/null
}
export PROMPT_COMMAND="nvm_enter_directory;$PROMPT_COMMAND"


# Python
# Use the brew-installed python instead of the OSX version
alias python-og="$(which python)"
alias python="$(which python2)"
alias pip="$(which pip2)"

source ~/.bash_scripts/haiku.sh
[[ -f ~/.bash_scripts/nr.sh ]] && source ~/.bash_scripts/nr.sh

# Autocomplete
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  . "$(brew --prefix)/etc/bash_completion"
fi
if [ -d "$(brew --prefix)/etc/bash_completion.d" ]; then
  for completion in "$(brew --prefix)/etc/bash_completion.d"/*; do
    # Only include files
    [ ! -f "$completion" ] && continue

    case $(basename "$completion") in
      # Skip some includes, because historically they've had syntax errors
      gcc|ifupdown|ipsec|kldload|man|net-tools)
        continue;;
      pkg_install|procps|wireless-tools|yum-arch)
        continue;;
    esac

    . "$completion"
  done
fi

# Load AutoJump
# via `brew install autojump`
if [ -f /usr/local/etc/profile.d/autojump.sh ]; then
  . /usr/local/etc/profile.d/autojump.sh
fi

# Bundler shortcuts
# via http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
alias b="bundle"
alias bi="b install"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && bil && echo '.bundle/' >> .gitignore && echo 'vendor/cache/' >> .gitignore"
