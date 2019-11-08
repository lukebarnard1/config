#!/bin/sh

rand () {
  echo $((1 + RANDOM % ${1:-100}))
}

lorem () {
  l=$(wc -l ~/.lorem | grep -o [0-9]*)
  a=$(rand $l)
  head -n$a ~/.lorem | tail -n1
}

react_component () {
	local name=$1

	if [[ -z $name ]]; then
    echo 'Please specify component name'
    return 1
  fi

  mkdir $name
  cd $name
  echo "import React from 'react'
import {
} from './styles'

const $name = () => (
  <div>$name</div>
)

$name.propTypes = { }

export default $name" > $name.js

  echo "export { default } from './$name'" > index.js

  touch styles.js
}

gcf () {
	local choice=""

	choice=$(git branch --sort=-committerdate | fzf)

	if [[ -n $choice ]]; then
		git checkout $choice
	fi
}

vimo () {
  files=$(cat <&0;)

  vim -p $files
}

# aliases
alias gs='git status -su'
alias gst='git status -u'
alias gl='git log'
alias glp='git log -p'
alias gac='git commit -a -m${0} -m{1}'
alias gch='git checkout'
alias gchm='git checkout master'
alias gchb='git checkout -b'
alias gpl='git pull'
alias gd='git diff'
alias gdnr='git diff --name-only --relative'
alias gdv='gdnr | vimo'
alias gdvn='git ls-files --modified --others --exclude-standard | vimo'
alias gdc='git diff --cached'
alias gpoh='git push -u origin HEAD'
alias gstnd='git log --author=Luke'
alias ggrp='git grep'

alias dc='docker-compose'
alias dk='docker'

git_branch() {
  if git status &>/dev/null; then
    echo "| branch: "$(colored 31)$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')$(unformat)
    printf " "
  fi
}

current_commit() {
  if git status &>/dev/null; then
    echo "| commit: "$(git log -n1 --pretty=format:%s 2> /dev/null)
    printf " "
    echo "| hash:   "$(git log -n1 --pretty=format:%H 2> /dev/null)
    printf " "
  fi
}

colored() {
  printf "\033[01;"$1"m"
}

unformat() {
  printf "\033[00m"
}

# set prompt
PS1="\n  __________________________________________________________________\n |\n \$(current_commit)\$(git_branch)| dir:    \$(colored 34)\w\$(unformat)  \n |__________________________________________________________________\n\n "

fix_history () {
  history -a
  history -n
}

# fix history

HISTSIZE=5000
HISTFILESIZE=10000

export PROMPT_COMMAND="fix_history; $PROMPT_COMMAND"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"

# add ssh key
keychain --quiet

keys=$(ssh-add -l | grep id_rsa | wc -l)
if [[ $keys == "0" ]]; then
  ssh-add
fi

export CONFIG_DEV_DIR=$HOME/.config/dev

source $CONFIG_DEV_DIR/pin/pin.sh
