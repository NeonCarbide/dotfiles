local _M = {
    browser     = 'vivaldi-stable',
    editor      = 'nvim',
    files       = 'dolphin',
    terminal    = 'alacritty',
}

_M.editor_cmd   = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd   = _M.terminal .. ' -e man awesome'

_M.autostart    = {
    'picom',
    'numlockx on',
    'xmodmap ~/.Xmodmap',
    'discord',
}

return _M
