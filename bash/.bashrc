#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

# prepend 'cd' when just a path is entered
shopt -s autocd

# autocorrect path
shopt -s cdspell

# check if window sized has changed
shopt -s checkwinsize

# ignore case when searching
shopt -s nocaseglob

PS1='\u@\h :: \W \$ '

fortune -s | cowthink -f moose -n && echo 
