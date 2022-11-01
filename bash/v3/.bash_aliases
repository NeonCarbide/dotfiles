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

# require confirmation by default for cp, mv, and rm
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# clean terminal to newly opened state
alias clean='clear && fortune -s | cowthink -f moose -n && echo'

# reboot and shutdown faster
alias rb='sudo reboot'
alias sd='sudo shutdown' 
alias sdn='sudo shutdown now' 

# cd to $HOME and clean
alias ~='cd ~ && clean'

# launch mpv with audio profile
alias mpa='mpv --profile=audio'

# launch mpv with video profile
alias mpv='mpv --profile=video'

### FUNCTIONS ###

# make directory then cd into it
mkcd () {
    mkdir -pv $1
    cd $1
}

# search youtube and launch mpv with audio profile
mpas () {
    mpv --profile=audio ytdl://ytsearch:"$*"
}

# search youtube and launch mpv with video profile
mpvs () {
    mpv --profile=video ytdl://ytsearch:"$*"
}

# change wallpaper and rebuild dwm
chwal () {
    wal -i ${1:-"$HOME/.local/share/backgrounds/"}
    killall dunst
    dunst -config $HOME/.config/dunst/dunstrc &
    case $2 in
        dwm)
            /bin/bash $HOME/sources/dwm/build.sh
            xdotool key super+control+r
            ;;
        *)
            ;;
    esac
}

# test terminal for 256-colour support
aa_256 () { 
    local o= i= x=`tput op` cols=`tput cols` y= oo= yy=;
    y=`printf %$(($cols-6))s`;
    yy=${y// /=};
    for i in {0..256};
    do
        o=00${i};
        oo=`echo -en "setaf ${i}\nsetab ${i}\n"|tput -S`;
        echo -e "${o:${#o}-3:3} ${oo}${yy}${x}";
    done
}

# start x faster
x () { 
    clean
    startx ~/.config/X11/xinitrc ${1:-dwm}
}

### KEYBINDS ###

# use clean instead of clear for C-l
bind '"\C-l":"\C-k \C-u\nclean\n"'
