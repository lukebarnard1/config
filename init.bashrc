#!/bin/sh

gcf () {
	local choice=""

	choice=$(git branch | fzf)

	if [[ -n $choice ]]; then
		git checkout $choice
	fi
}

vimo () {
  files=$(cat <&0;)

  vim -p $files
}

# aliases
alias gs='git status -s'
alias gst='git status'
alias gl='git log'
alias gac='git commit -a -m${0} -m{1}'
alias gch='git checkout'
alias gchm='git checkout master'
alias gchb='git checkout -b'
alias gpl='git pull'
alias gd='git diff'
alias gdnr='git diff --name-only --relative'
alias gdv='gdnr | vimo'
alias gdc='git diff --cached'
alias gpoh='git push -u origin HEAD'
alias gstnd='git log --author=Luke'
alias ggrp='git grep'

alias dc='docker-compose'
alias dk='docker'

# set prompt
#PS1=' \[\033[1;34m\]\w\[\033[0m\] \$ '

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"

# start keychain
#keychain --quiet

# add ssh key if there are no keys added
keys=$(ssh-add -l &> /dev/null | grep id_rsa | wc -l)
if [[ $keys == "0" ]]; then
  ssh-add
fi

export CONFIG_DEV_DIR=$HOME/.config/dev

source $CONFIG_DEV_DIR/pin/pin.sh
