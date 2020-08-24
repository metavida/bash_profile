#!/bin/sh

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

read -p "Create symlinks to the $BASH_SCRIPTS_DIR directory? [yN] " yn
  case $yn in
    [Yy]* ) echo "Installing ...";;
    * ) echo "Canceled. No changes made." && exit 0;;
  esac

echo "~/.zshrc : Creating symlink..."
mv ~/.zshrc ~/.zshrc.pre-bash_scripts
ln -nfs "$BASH_SCRIPTS_DIR/zshrc" ~/.zshrc

echo "~/.gitconfig : Creating symlink..."
mv ~/.gitconfig ~/.gitconfig.pre-bash_scripts
ln -nfs "$BASH_SCRIPTS_DIR/gitconfig" ~/.gitconfig

if [ ! -f $BASH_SCRIPTS_DIR/zsh-custom/keys.zsh ]; then
  echo "keys.zsh : Creating empty placeholder..."
  cat > $BASH_SCRIPTS_DIR/zsh-custom/keys.zsh <<KEYS
# Place environment variables containing local secrets in this file

# export SECRETS=TBD
KEYS
fi

echo ""
echo "Configuration complete!!"
echo ""
echo "1. Install apps at the bottom of $BASH_SCRIPTS_DIR/install.sh via the 'brew install' commands."
echo "2. Add secret exports in the $BASH_SCRIPTS_DIR/zsh-custom/keys.zsh file."
exit 0

echo "Configure homebrew"
brew tap homebrew/cask
brew tap homebrew/cask-fonts

echo "Installing fonts"
brew cask install font-fira-code

# Starship prompt
brew install starship
# JSON querying magic ✨
brew install jq
# Ruby Version Manager
brew install rbenv
# Node Version Manager
brew install nvm
