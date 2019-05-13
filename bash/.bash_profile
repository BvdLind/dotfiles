#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="vim"
export BROWSER="firefox"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
