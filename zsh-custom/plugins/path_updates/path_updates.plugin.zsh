# sudobin is Marcos' way of not just letting homebrew override any old system binary
# Setup automatically via ./install.sh or manually via:
#     sudo mkdir "$(brew --prefix)/sudobin" && sudo chmod 755 "$(brew --prefix)/sudobin" && sudo -k
export PATH="$(brew --prefix)/sudobin:$PATH:/usr/local/sbin"

# Path to my personal scripts
# Leading commas inspired by https://rhodesmill.org/brandon/2009/commands-with-comma/
if [ -d "$BASH_SCRIPTS_DIR/bin" ]; then
  export PATH="$PATH:$BASH_SCRIPTS_DIR/bin"
else
  echo "No personal scripts added to PATH: $BASH_SCRIPTS_DIR/bin does not exist"
fi
