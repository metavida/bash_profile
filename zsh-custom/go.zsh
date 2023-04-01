GOPATH_FROM_GO="$(go env GOPATH 2>/dev/null)"

if [ $? -eq 0 ]; then
  export GOPATH="$GOPATH_FROM_GO"
elif [ -d "$HOME/workspace" ]; then
  GOPATH=$HOME/workspace/go
elif [ -d "$HOME/personalspace" ]; then
  GOPATH=$HOME/personalspace/go
fi
