local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi

local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(320) .. ' -show drun -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

local _A = {
    default = {
        browser = 'vivaldi-stable',
        editor = os.getenv('EDITOR') or 'nvim',
        files = 'dolphin',
        lock = 'slock',
        rofi = rofi_command,
        terminal = os.getenv('TERMINAL') or 'alacritty'
    },

    autostart = {
        'picom',
        'numlockx on',
        'xmodmap ~/.Xmodmap',
        'discord'
    }
}

_A.default.editor_cmd = _A.default.terminal .. ' -e ' .. _A.default.editor

return _A
