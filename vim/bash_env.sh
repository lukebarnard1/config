# init.vim will set BASH_ENV to this file
# which will cause it to be evaluated before
# running any command that is invoked with !

# make sure aliases are enabled, by default
# they are not enabled in a non-interactive
# shell
shopt -s expand_aliases
# load aliases
source $CONFIG_DEV_DIR/bash/aliases.sh
