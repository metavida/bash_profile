#!/bin/bash

# sudobin is Marcos' way of not just letting homebrew override any old system binary
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

# Import my custom .bash_scripts
source ~/.bash_scripts/ps1.sh
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

# Bundler shortcuts
# via http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
alias b="bundle"
alias bi="b install"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && bil && echo '.bundle/' >> .gitignore && echo 'vendor/cache/' >> .gitignore"
