baconipsum() {
  local numParas="$1"
  if [[ "$numParas" =~ ^--?h ]]; then
    echo "Usage: baconipsum [<num-paragraphs>] | --help"; return 0
  elif [ -z "$numParas" ]; then
    numParas=1
  fi
  if [[ ! "$numParas" =~ ^[0-9]+$ ]]; then
    echo "Error: The first argument must be a number" >&2; return 3
  fi
  curl -sS "https://baconipsum.com/api/?type=meat-and-filler&start-with-lorem=1&paras=$numParas" >&1 | jq -r 'join("\n\n")'
}
