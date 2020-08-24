# Configure the prompt with Starship
# Install with `brew install starship`

# Specify our config path
export STARSHIP_CONFIG="$BASH_SCRIPTS_DIR/starship.toml"

# Start up my starship!
command -v starship >/dev/null && eval "$(starship init zsh)"
