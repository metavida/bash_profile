#!/bin/sh
set -euo pipefail

# Get the name of the current folder
BASH_SCRIPTS_DIR="${PWD}"

if [ -z "$BASH_SCRIPTS_DIR" ]; then
  echo "ERROR: No BASH_SCRIPTS_DIR environment variable set."
  exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "ERROR: Please install oh-my-zsh first (no ~/.oh-my-zsh directory found)"
  echo "https://ohmyz.sh/#install"
  exit 2
fi

echo "Create symlinks to the $BASH_SCRIPTS_DIR directory? [yN] "
read -r yn
  case $yn in
    [Yy]* ) echo "Installing ...";;
    * ) echo "Canceled. No changes made." && exit 0;;
  esac

echo "~/.zshrc : Creating symlink..."
mv ~/.zshrc ~/.zshrc.pre-bash_scripts || true
ln -nfs "$BASH_SCRIPTS_DIR/zshrc" ~/.zshrc

echo "~/.gitconfig : Creating symlink..."
mv ~/.gitconfig ~/.gitconfig.pre-bash_scripts || true
ln -nfs "$BASH_SCRIPTS_DIR/gitconfig" ~/.gitconfig

if [ ! -f "$BASH_SCRIPTS_DIR/zsh-custom/keys.zsh" ]; then
  echo "keys.zsh : Creating empty placeholder..."
  cat > "$BASH_SCRIPTS_DIR/zsh-custom/keys.zsh" <<KEYS
# Place environment variables containing local secrets in this file

# export SECRETS=TBD
KEYS
fi

SUDOBIN_PATH="$(brew --prefix)/sudobin"
echo "$SUDOBIN_PATH : Creating folder (requires sudo)..."
echo ""
if [ ! -d "$SUDOBIN_PATH" ]; then
  sudo mkdir "$SUDOBIN_PATH"
fi
sudo chmod 755 "$SUDOBIN_PATH"
sudo chown root:wheel "$SUDOBIN_PATH"
sudo -k

echo ""
echo "Configuration complete!!"
echo ""
echo "1. Install apps at the bottom of $BASH_SCRIPTS_DIR/install.sh via the 'brew install' commands."
echo "2. Symlink apps to sudobin to override system defaults (e.g. sudo ln -nfs $(brew --prefix)/bin/git $SUDOBIN_PATH/git"
echo "3. Add secret exports in the $BASH_SCRIPTS_DIR/zsh-custom/keys.zsh file."
exit 0

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

# Starship prompt
brew install starship

# Install the latest git
brew install git
sudo ln -nfs "$(brew --prefix)/bin/git" "$(brew --prefix)/sudobin/git"

# Pick a version management option!
# OPTION 1: asdf all-the-things:
# First, install prerequisites listed here: https://asdf-vm.com/#/core-manage-asdf
brew install gpg asdf
# Add language-specific plugins
asdf plugin-add ruby
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs
# Determine the current latest node version https://nodejs.org/en/download/
asdf install nodejs 14.16.0
asdf global nodejs 14.16.0



# Search all the files with `ag`!
brew install the_silver_searcher
# cd quickly with `j`!
brew install autojump
# JSON querying magic ✨
brew install jq
# Powerful CSV tooling
brew install miller
# shell linter
brew install shellcheck
# short & sweet man pages
brew install tldr
# dip - to help with dev mode in Docker
brew tap bibendi/dip
brew install dip
