#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# source aliases
if [ -f "$HOME/.bash_aliases" ]; then
	. "$HOME/.bash_aliases"
fi

# import colours from wal asynchronously
(cat ~/.cache/wal/sequences &)

# set default pager
export PAGER='less'

# set default editor
#export VISUAL='emacsclient -c -a ""'
export VISUAL='urxvtc -e vim'
export EDITOR='vim'

# prepend 'cd' when just a path is entered
shopt -s autocd

# ignore case when searching
shopt -s nocaseglob

fortune -s | cowthink -f moose -n && echo

PS1='\u@\h :: \W \$ '

# modify PS1 if in a shell spawned by ranger
[[ -n "$RANGER_LEVEL" ]] && export PS1="[r] $PS1"
