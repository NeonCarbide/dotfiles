#
# ~/.bash_aliases
#

# enable colour support for various aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'
    
    alias ls='ls --color=auto'
fi

# ls aliases
alias l='ls -CF'
alias la='ls -aCF'
alias ll='ls -AFGhl'

# always mkdir -pv
alias mkdir='mkdir -pv'

# always resume previous download if available
alias wget='wget -c'

# require confirmation for mv and rm
alias mv='mv -i'
alias rm='rm -i'

mkcd () {
    mkdir -pv $1
    cd $1
}
