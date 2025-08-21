# Load zsh tab autocomplete installed by homebrew packages
zsh_brew_completions="$(brew --prefix)/share/zsh/site-functions"
if [ -d "$zsh_brew_completions" ]; then
  fpath=("$zsh_brew_completions" $fpath)
  autoload -Uz compinit && compinit
fi
