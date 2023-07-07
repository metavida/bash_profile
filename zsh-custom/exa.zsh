command -v exa >/dev/null
if [[ $? -eq 0 ]]; then
  alias ls="exa -g"
  alias ll="exa -lag"
else
  echo "Skipped alias: No 'exa' found"
fi
