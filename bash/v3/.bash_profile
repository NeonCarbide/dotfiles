#
# ~/.bash_profile
#

# add ~/.local/bin to PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="${HOME}/.local/bin:${PATH}"

# add ~/.scripts to PATH
[[ ":$PATH:" != *":$HOME/.scripts:"* ]] && export PATH="${HOME}/.scripts:${PATH}"

# source .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# start x server on login to tty1
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
	startx ~/.config/X11/xinitrc xmonad
fi

