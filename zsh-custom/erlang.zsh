# kerl build/install options
# https://github.com/asdf-vm/asdf-erlang#use
# https://dev.to/andresdotsh/how-to-install-erlang-on-macos-with-asdf-3p1c
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl)"
