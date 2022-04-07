# About install.sh

This file does the heavy lifting to do first-time configuration & app installation.

This README file explains a bit of the history/details of what's being installed w/ relevant links & such.

## Fonts

I love installing fonts with homebrew!

```shell
echo "Configure homebrew"
brew tap homebrew/cask
brew tap homebrew/cask-fonts

echo "Installing fonts"
# https://github.com/tonsky/FiraCode
brew install font-fira-code
# https://www.jetbrains.com/lp/mono/
brew install font-jetbrains-mono
# https://github.com/rbanffy/3270font
brew install font-3270
```

## Programing language version control

I've switched to using [asdf](https://asdf-vm.com).



## Other favorite apps!

```shell
# Starship makes my CLI prompt config a breeze
brew install starship
# Install exa to replace `ls`
brew install exa
# Search all the files with `ag`!
brew install the_silver_searcher
# cd quickly with `j`!
brew install autojump
# JSON querying magic ✨
brew install jq
# Like jq but for YAML, TOML, CSV, & more
brew install dasel
# shell linter
brew install shellcheck
# short & sweet man pages
brew install tldr
# https://devutils.app to do all sorts of conversion things
brew install devutils
# dip - to help with dev mode in Docker
brew tap bibendi/dip
brew install dip
```