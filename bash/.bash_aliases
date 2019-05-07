#set -o vi
shopt -s autocd
alias i3r="i3-msg restart"
alias grep='grep --color=auto'
alias brc='source ~/.bashrc'
alias ls='ls -hF --color=auto'
alias lr='ls -R'
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
alias g="git"
alias lpass_fzf='lpass show -c --password $(lpass ls  | fzf | awk "{print $(NF)}" | sed "s/\]//g")'
alias q="exit"
alias e.="nnn ."
#export TERM=xterm-256color
export GIT_EDITOR=vim
alias stage-verslag="cd ~/Documents/stage-dingen/onderzoeksverslag-stage/"
alias downloads="cd ~/Downloads/"
alias documents="cd ~/Documents/"
alias boeken="cd ~/Documents/Boeken/"
alias mountguru="cd ~/Documents/mountguru"
alias mg-pwa="cd ~/Documents/mobile-web-app"
alias .vim="cd ~/.vim"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#symfony aliases
alias sym:cdb="php app/console doctrine:database:create"
alias sym:udb="php app/console doctrine:schema:update --force"
alias sym:sr="php app/console server:r"
alias sym56:cdb="php56 app/console doctrine:database:create"
alias sym56:udb="php56 app/console doctrine:schema:update --force"
alias sym56:sr="php56 app/console server:r"

# git aliases
alias glb="git log --branches --date-order"
alias gl="git log --oneline --all --graph --decorate  $*"
alias ga="git add -A $*"
alias grep="grep -nRi $*"
alias gac="git add -A :/ $T git commit -e"
alias gacm="git add -A :/ $T git commit -m $*"
alias gau="git add -u"
alias gb="git branch -v $*"

alias gbb="git bisect bad $*"
alias gbg="git bisect good $*"
alias gbr="git bisect reset $*"

alias gc="git commit $*"
alias gch="git checkout $*"
alias gchm="git checkout master"
alias gcm="git commit --amend"
alias gcount="git rev-list HEAD --count"

alias gd="git diff -w $*"
alias gdc="git diff -w --cached"
alias gdf="git diff -w --full-index"

alias gf="git fetch $*"
alias gfu="git fetch upstream $T git rebase upstream/master"

alias gg="git grep $*"

alias gp="git push $*"
alias gpl="git pull $*"
alias gpm="git push origin master"
alias gps="git push origin source"

alias gr="git reset head $*"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grb="git rebase master"
alias grbi="git rebase -i master"
alias gru="git remote update"

alias gs="git status"
alias gsa="git stash apply"
alias gsl="git shortlog -n -s"
alias gsp="git stash pop"
alias gst="git stash $*"
alias gstl="git stash list"
alias c="printf '\033c'"

alias gwhat="git whatchanged --oneline"
