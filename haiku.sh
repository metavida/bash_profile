#!/bin/bash

# All the things related to Haiku Learning code

# MySQL Sandbox
export SANDBOX_HOME="$HOME/.mysql_sb"
#export SANDBOX_FOR_HAIKU="$SANDBOX_HOME/rsandbox_5_5_33"
export SANDBOX_FOR_HAIKU="$SANDBOX_HOME/rsandbox_5_6_25"
export BINARY_BASE="$HOME/.mysql_sb_bin"
#export BINARY_VERSION_FOR_HAIKU="5.5.33"
export BINARY_VERSION_FOR_HAIKU="5.6.25"
export BINARY_DIR_FOR_HAIKU="$BINARY_BASE/$BINARY_VERSION_FOR_HAIKU"

export DYLD_LIBRARY_PATH=$BINARY_DIR_FOR_HAIKU/lib:$DYLD_LIBRARY_PATH

# Old Redis for haiku_lms
alias redis1310="/usr/local/Cellar/redis1310/1.3.10/bin/redis-server"
