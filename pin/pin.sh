PIN_DIR=$HOME/.pin

if [[ ! -d $PIN_DIR ]]; then
  mkdir $PIN_DIR
fi

if [[ -e $PIN_DIR/last ]]; then
  cd $(cat $PIN_DIR/last)
fi

pin () {
  local firstArg=$1
  local choice=""

  if [[ $firstArg == "here" ]]; then
    p=$(pwd)
    echo ${p##$HOME} >> $PIN_DIR/ls
    cat $PIN_DIR/ls | sort -u > $PIN_DIR/ls^
    mv $PIN_DIR/ls^ $PIN_DIR/ls
  elif [[ $firstArg == "help" ]]; then
    less $CONFIG_DEV_DIR/pin/help.txt
  elif [[ -z $firstArg ]]; then
    if [[ $(fzf --version &>/dev/null;echo $?) -ne 0  ]]; then
      echo 'To use fuzzy search, please install fzf:'
      echo ' git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf'
      echo ' ~/.fzf/install'
      return 1
    fi;
    choice=$(cat $PIN_DIR/ls | fzf)
  else
    choice=$(grep -m1 -e "$firstArg" $PIN_DIR/ls)
  fi

  if [[ -n $choice ]]; then
    cd $HOME$choice
    echo $HOME$choice > $PIN_DIR/last
  fi
}

gt () {
  if [[ $(fzf --version &>/dev/null;echo $?) -ne 0  ]]; then
    echo 'To use fuzzy search, please install fzf:'
    echo ' git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf'
    echo ' ~/.fzf/install'
    return 1
  fi;

  local prev=`pwd`

  cd
  `__fzf_cd__`

  if [[ $(echo $?) -eq 0 ]]; then
    pwd > $PIN_DIR/last
  else
    cd $prev
  fi
}
