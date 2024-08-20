command -v doggo >/dev/null
if [[ $? -eq 0 ]]; then
  alias dig="doggo"
else
  echo "Skipped alias: No 'doggo' found"
fi
