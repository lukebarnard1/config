#!/bin/sh

export CONFIG_DEV_DIR=$HOME/.config/dev

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

  cp $CONFIG_DEV_DIR/template.stories.js $name.stories.js

  sed -i s/Component/$name/g $name.stories.js

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

vimd () {
	local choice=""

	choice=$(gdnr | fzf --ansi --preview='git diff --color {}')

	if [[ -n $choice ]]; then
		vim $choice
	fi
}

vimo () {
  files=$(cat <&0;)

  vim -p $files
}

# aliases
ALIAS_FILE=$CONFIG_DEV_DIR/bash/aliases.sh
source $ALIAS_FILE

alias vimals="vim $ALIAS_FILE;source $ALIAS_FILE"

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
    echo $(colored '38;5;200')$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')$(unformat)
  fi
}

current_hash() {
  if git status &>/dev/null; then
    echo $(git log -n1 --abbrev=8 --pretty=format:%h 2> /dev/null)
  fi
}
current_commit() {
  if git status &>/dev/null; then
    echo $(git log -n1 --pretty=format:%s 2> /dev/null)
  fi
}

colored() {
  printf "\033["$1"m"
}

unformat() {
  printf "\033[00m"
}


# set prompt
PS1="\n \$(frame tl)\$(frame h \$((\$(width) - 4)))\n \$(frame v) commit: \$(current_commit)\n \$(frame v) hash:   \$(current_hash)\n \$(frame v) branch: \$(git_branch)\n \$(frame v) dir:    \$(colored 32)\w\$(unformat)  \n \$(frame bl)\$(frame h \$((\$(width) - 4)))\n\n  vi -  "

PS1="\n\$(colored 32)\w\$(unformat) \$(git_branch) \$(current_hash) \n - "

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

source $CONFIG_DEV_DIR/pin/pin.sh
