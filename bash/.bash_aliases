# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias grep='grep --color=auto'
    alias ls='ls --color=auto'
fi

# ls aliases
alias l='ls -CF'
alias la='ls -AF'
alias ll='ls -aFGl'

# scrot auto filenaming
alias scrot='scrot "scrot_%Y-%m-%d_%T.png"'
