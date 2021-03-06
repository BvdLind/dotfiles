#
# ~/.bashrc
#

if [[ $DISPLAY ]]; then
  # If not running interactively, don't do anything
  [[ $- != *i* ]] && return
  [[ -z "$TMUX" ]] && exec tmux
fi

shopt -s autocd

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_functions.bash ] && . ~/.bash_functions.bash

# FZF config
[ -f ~/.fzf.bash ] && . ~/.fzf.bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'
bind -x '"\C-a": tmux'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

export PS1="\001\033[38;5;6m\002\u@\h\001$(tput sgr0)\002\001\033[38;5;15m\002\001$(tput bold) \002\001$(tput sgr0)\002\001\033[38;5;14m\002\w\001$(tput sgr0)\002\001$(tput sgr0)\002\001\033[38;5;15m\002\[\033[32m\]\]\$(parse_git_branch)\001\033[00m\002 > \001$(tput sgr0)\002"

. /usr/share/autojump/autojump.sh
. /home/bas/.cache/wal/colors.sh
# . /usr/share/doc/pkgfile/command-not-found.bash
. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash

PATH="$HOME/apache-maven-3.6.3/bin:$HOME/.config/composer/vendor/bin:$HOME/perl5/bin:/opt/android-studio/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"~/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=~/perl5"; export PERL_MM_OPT;
PATH="$PATH:$HOME/Documents/flutter/bin"
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
# export ANDROID_HOME=$HOME/Android/Sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bas/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bas/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/bas/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bas/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

