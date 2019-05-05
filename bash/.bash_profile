#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="vim"
export BROWSER="firefox"

if [[ $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
