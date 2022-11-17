local _V = {}

_V.browser  = 'vivaldi-stable'
_V.editor   = 'nvim'
_V.files    = 'dolphin'
_V.terminal = 'alacritty'

_V.editor_cmd   = _V.terminal .. ' -e ' .. _V.editor

return _V
