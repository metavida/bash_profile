command -v dog >/dev/null
if [[ $? -eq 0 ]]; then
  alias dig="dog"
else
  echo "Skipped alias: No 'dog' found"
fi
