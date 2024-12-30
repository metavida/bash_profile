#!/bin/sh
set -euo pipefail

DO_DOTFILES=0
DO_SSH=0
DO_BREW=0
DO_ASDF=0

usage() {
    cat <<EOF

Use this script to configure a new Mac with my preferred settings.

Usage:
  ./install/install.sh <option>
  ./install/install.sh --help

Options: (typically run in this order)
  --dotfiles Install dotfiles
  --ssh      Configure ssh
  --brew     Install Homebrew packages
  --asdf     Install ASDF version management tools

EOF
}

opt="${1:---help}";
case "$opt" in
    "--help" | "-h" )
        usage; exit 0;;
    "--dotfiles" )
        DO_DOTFILES=1;;
    "--ssh" )
        DO_SSH=1;;
    "--brew" )
        DO_BREW=1;;
    "--asdf" )
        DO_ASDF=1;;
    *)
      echo >&2 "Invalid option: $opt"
      usage
      exit 1;;
esac

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

if [ $DO_DOTFILES -eq 1 ]; then
  echo "Installing dotfiles..."

  echo "Create symlinks to the dotfiles in the $BASH_SCRIPTS_DIR directory? [yN] "
  read -r yn
    case $yn in
      [Yy]* )
        echo "~/.zshrc : Creating symlink..."
        mv ~/.zshrc ~/.zshrc.pre-bash_scripts || true
        ln -nfs "$BASH_SCRIPTS_DIR/zshrc" ~/.zshrc

        echo "~/.ssh/config : Creating symlink..."
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh
        mv ~/.ssh/config ~/.ssh/config.pre-bash_scripts || true
        ln -nfs "$BASH_SCRIPTS_DIR/sshconfig" ~/.ssh/config

        echo "~/.gitconfig : Creating symlink..."
        mv ~/.gitconfig ~/.gitconfig.pre-bash_scripts || true
        ln -nfs "$BASH_SCRIPTS_DIR/gitconfig" ~/.gitconfig

        echo "~/.iex.exs : Creating symlink..."
        mv ~/.iex.exs ~/.iex.exs.pre-bash_scripts || true
        ln -nfs "$BASH_SCRIPTS_DIR/iex.exs" ~/.iex.exs

        echo "~/.asdfrc : Creating symlink..."
        mv ~/.asdfrc ~/.asdfrc.pre-bash_scripts || true
        ln -nfs "$BASH_SCRIPTS_DIR/asdfrc" ~/.asdfrc
        ;;
      * ) echo "Skipped dotfile symlinks";;
    esac

  if [ ! -f "$BASH_SCRIPTS_DIR/zsh-custom/keys.zsh" ]; then
    echo "keys.zsh : Creating empty placeholder..."
  cat > "$BASH_SCRIPTS_DIR/zsh-custom/keys.zsh" <<KEYS
# Place environment variables containing local secrets in this file

# export SECRETS=TBD
KEYS
  fi

  echo ""
  echo "Dotfile Configuration Complete!!"
  echo ""
  echo "Next, install a bunch of apps with homebrew:"
  echo ""
  echo "    ./install/install.sh --brew"
  exit 0
fi

if [ $DO_SSH -eq 1 ]; then
  echo "Configuring SSH..."
  echo "Using guidance from https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
  echo ""

  SSH_PATH="$HOME/.ssh/id_ed25519"

  # If ~/.ssh/id_ed25519 already exists skip this step
  if [ -f "$SSH_PATH" ]; then
    echo "SSH key already exists, $SSH_PATH, skipping SSH key generation"
  else
    echo "Creating an SSH key pair for GitHub..."
    echo ""
    echo "IMPORTANT: Generate & Save the SSH key passphrase in 1Password!!"
    ssh-keygen -t ed25519 -C "webmaster@kuhnsfam.com"
  fi

  echo ""
  echo "Adding SSH key to the ssh-agent"
  # If ssh-agent is not running, start it
  pgrep -q ssh-agent || eval "$(ssh-agent -s)"
  ssh-add --apple-use-keychain "$SSH_PATH"
  pbcopy < "$SSH_PATH.pub"
  echo "Public key, $SSH_PATH.pub, copied to clipboard."
fi

if [ $DO_BREW -eq 1 ]; then
  command -v brew >/dev/null
  if [ $? -ne 0 ]; then
    echo "ERROR: Please install Homebrew first."
    echo "https://brew.sh/"
    exit 3
  fi

  echo "Installing Apps with Homebrew..."

  SUDOBIN_PATH="$(brew --prefix)/sudobin"
  echo "$SUDOBIN_PATH : Creating folder (requires sudo)..."
  echo ""
  if [ ! -d "$SUDOBIN_PATH" ]; then
    sudo mkdir "$SUDOBIN_PATH"
    sudo chmod 755 "$SUDOBIN_PATH"
    sudo chown root:wheel "$SUDOBIN_PATH"
    sudo -k
  fi

  echo "Install all homebrew packages"
  # install/README.md has details about why I picked some of these apps/packages
  brew bundle install

  echo ""
  if [ ! -f "$SUDOBIN_PATH/git" ]; then
    echo "Use the brew-installed git instead of system-provided git"
    sudo ln -nfs "$(brew --prefix)/bin/git" "$SUDOBIN_PATH/git"
  else
    echo "Skipping git symlink: $SUDOBIN_PATH/git already exists"
  fi

  echo ""
  echo "App installation via Homebrew Complete!!"
  echo ""
  echo "Next, configure asdf:"
  echo ""
  echo "    ./install/install.sh --asdf"
  exit 0
fi

if [ $DO_ASDF -eq 1 ]; then
  echo "Install version management tools"
  # Prerequisites(https://asdf-vm.com/#/core-manage-asdf) should be installed by `brew bundle`
  # Add language-specific plugins
  asdf plugin-add ruby
  asdf plugin-add erlang
  asdf plugin-add elixir
  asdf plugin-add nodejs
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
  # Determine the current latest node version https://nodejs.org/en/download/
  asdf install nodejs 20.16.0
  asdf global nodejs 20.16.0

  echo ""
  echo "asdf setup Complete!!"
  echo ""
  echo "A few next steps:"
  echo "1. Put secret exports in the $BASH_SCRIPTS_DIR/zsh-custom/keys.zsh file."
  echo "2. Open a new Terminal tab/window to experience the new setup."
  echo ""
  echo "Otherwise that's it! Enjoy your new Mac!"
  echo ""

  exit 0
fi
