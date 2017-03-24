#!/bin/bash

# sudobin is Marcos' way of not just letting homebrew override any old system binary
export PATH=/usr/local/sudobin:$PATH
# chefdk
export PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH
# link homebrew sbins
export PATH=$PATH:/usr/local/sbin
# go-installed binaries
export PATH=$PATH:/usr/local/gocode/bin

# Helpers
alias ll="ls -l"

# Import my custom .bash_scripts
source ~/.bash_scripts/ps1.sh
source ~/.bash_scripts/keys.sh

# foreman
alias fm="forego"
alias fms="fm start"

# git
alias gsu="git submodule update"
alias gdm="git diff | mate"

# Go
export GOPATH=/usr/local/gocode

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.bash_scripts/haiku.sh

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

# Docker
eval $(docker-machine env default)

# Bundler shortcuts
# via http://ryan.mcgeary.org/2011/02/09/vendor-everything-still-applies/
alias b="bundle"
alias bi="b install"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && bil && echo '.bundle/' >> .gitignore && echo 'vendor/cache/' >> .gitignore"
# Open a bundle-installed gem in your editor
# usage:   bo gem-name
mate_bundle_show() {
  local gem_path=
  gem_path=$(b show "$1")
  local b_show_ret=$?
  if [ $b_show_ret -eq 0 ]; then
    mate `b show "$1"`
  else
    echo "$gem_path"
    return $b_show_ret
  fi
}
alias bo=mate_bundle_show
