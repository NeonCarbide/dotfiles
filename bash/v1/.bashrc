#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\u :: \W > '

# alias definitions

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
