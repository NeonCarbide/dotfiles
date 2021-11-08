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

# clean terminal to newly opened state
alias clean='clear && fortune -s | cowthink -f moose -n && echo'

# get dwm patch
alias get-dwm-patch='wget -P "$HOME/sources/dwm/patches/"'

# write 'sudo aura' quicker
alias saura='sudo aura'

# update everything using aura
alias aura-update='sudo aura -Syu && sudo aura -Akuax'

# launch mpv with audio profile
alias mpa='mpv --profile=audio'

# launch mpv with video profile
alias mpv='mpv --profile=video'

# search youtube and launch mpv with audio profile
mpas () {
    mpv --profile=audio ytdl://ytsearch:"$*"
}

# search youtube and launch mpv with video profile
mpvs () {
    mpv --profile=video ytdl://ytsearch:"$*"
}

# make directory then cd into it
mkcd () {
    mkdir -pv $1
    cd $1
}
