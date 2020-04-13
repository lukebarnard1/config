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
alias gc='git commit -vp'
alias gap='git add -p'
alias gch='git checkout'
alias gchm='git checkout master'
alias gchb='git checkout -b'
alias gpl='git pull'
alias gd='git diff'
alias gdls='git ls-files --modified --others --exclude-standard'
alias gdv='gdls | vimo'
alias gdc='git diff --cached'
alias gpoh='git push -u origin HEAD'
alias gstnd='git log --author=Luke'
alias ggrp='git grep'

alias dc='docker-compose'
alias dk='docker'

width() {
  stty size|if read r c
  then
    echo $c
  fi
}

frame() {
  N=${2:-1}

  while [[ $N -gt 0 ]]
  do
    N=$((N - 1))
    case "$1" in
      tl)
        printf '\xe2\x94\x8c'
        ;;
      tr)
        printf '\xe2\x94\x8c'
        ;;
      bl)
        printf '\xe2\x94\x94'
        ;;
      br)
        printf '\xe2\x94\x98'
        ;;
      v)
        printf '\xe2\x94\x82'
        ;;
      h)
        printf '\xe2\x94\x80'
        ;;
      *)
        ;;
    esac
  done
}

git_branch() {
  if git status &>/dev/null; then
    frame v
    echo " branch: "$(colored 33)$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')$(unformat)
    printf " "
  fi
}

current_commit() {
  if git status &>/dev/null; then
    frame v
    echo " commit: "$(git log -n1 --pretty=format:%s 2> /dev/null)
    printf " "
    frame v
    echo " hash:   "$(git log -n1 --pretty=format:%H 2> /dev/null)
    printf " "
  fi
}

colored() {
  printf "\033["$1"m"
}

unformat() {
  printf "\033[00m"
}


# set prompt
PS1="\n \$(frame tl)\$(frame h \$((\$(width) - 4)))\n \$(current_commit)\$(git_branch)\$(frame v) dir:    \$(colored 32)\w\$(unformat)  \n \$(frame bl)\$(frame h \$((\$(width) - 4)))\n\n  - "

fix_history () {
  export HISTFILE=~/.bash_history
  history -a
  history -c
  history -r
  #history -n
}

# fix history
export HISTSIZE=5000
export HISTFILESIZE=10000

export PROMPT_COMMAND="fix_history; $PROMPT_COMMAND"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"

command_exists() {
  command -V $1 &>/dev/null
}


# ubuntu keychain?
if command_exists keychain; then
  keychain --quiet
fi

# macos

# add ssh key
keys=$(ssh-add -l | grep id_rsa | wc -l)
if [[ $keys == "0" ]]; then
  ssh-add
fi

export CONFIG_DEV_DIR=$HOME/.config/dev

source $CONFIG_DEV_DIR/pin/pin.sh
