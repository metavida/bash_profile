command -v eza >/dev/null
if [[ $? -eq 0 ]]; then
  alias ls="eza --group"
  alias ll="eza --group --long --all"
else
  echo "Skipped alias: No 'eza' found"
fi
