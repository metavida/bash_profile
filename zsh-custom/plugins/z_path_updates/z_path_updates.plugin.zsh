# sudobin is Marcos' way of not just letting homebrew override any old system binary
# Setup automatically via ./install.sh or manually via:
#     sudo mkdir "$(brew --prefix)/sudobin" && sudo chmod 755 "$(brew --prefix)/sudobin" && sudo -k
export PATH="$(brew --prefix)/sudobin:$PATH:/usr/local/sbin"
