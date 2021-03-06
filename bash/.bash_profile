#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export TERMINAL="alacritty"
export EDITOR="vim"
# export BROWSER="firefox"
export BROWSER="brave-browser"
export ANDROID_HOME=/opt/android-studio/plugins/android/lib

PATH=$PATH:~/.local/bin

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

export PATH="$HOME/.cargo/bin:$PATH"
