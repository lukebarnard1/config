alias gs='git status -su'
alias gst='git status -u'
alias gl='git log'
alias glp='git log -p'
alias gac='git commit -a -m${0} -m{1}'
alias gan='git add -N .'
alias gc='git commit -vp'
alias gap='git add -p'
alias gch='git checkout'
alias gchm='git checkout main'
alias gchb='git checkout -b'
alias gpl='git pull'
alias gd='git diff'
alias gdls='git ls-files --modified --others --exclude-standard'
alias gdv='gdls | vimo'
alias gdc='git diff --cached'
alias gpoh='git push -u origin HEAD'
alias gstnd='git log --author=Luke'
alias ggrp='git grep'
alias gdnr='git diff --name-only --relative'
alias oops='gdnr HEAD^ | vimo'
alias gtrg='git commit -m"Trigger CI" --allow-empty'

alias dc='docker-compose'
alias dk='docker'

alias nrb='npm run build'
alias nrs='npm run start'
alias ni='npm install'

alias dateu='date -u +%Y-%m-%dT%H:%M:%SZ'

alias glp="git log --date=short --pretty='%h %cd :%<|(45) %an %s'"

alias conf="vim $CONFIG_DEV_DIR"
