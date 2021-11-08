#
# ~/.profile
#

# add ~/.local/bin to PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="${HOME}/.local/bin:${PATH}"

export EDITOR='nvim'
export RANGER_LOAD_DEFAULT_RC=FALSE

# run startx on login if logged in to tty1
if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec startx
fi
