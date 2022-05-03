if [ -d "$HOME/workspace" ]; then
  GOPATH=$HOME/workspace/go
elif [ -d "$HOME/personalspace" ]; then
  GOPATH=$HOME/personalspace/go
fi