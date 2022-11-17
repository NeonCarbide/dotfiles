local awful = require('awful')

local _M    = {}

local buttonmap = awful.button

_M.buttons  = {
    buttonmap{
        modifiers   = {},
        button      = 1,
        on_press    = function() awful.layout.inc(1) end,
    },
    buttonmap{
        modifiers   = {},
        button      = 3,
        on_press    = function() awful.layout.inc(-1) end,
    },
    buttonmap{
        modifiers   = {},
        button      = 4,
        on_press    = function() awful.layout.inc(-1) end,
    },
    buttonmap{
        modifiers   = {},
        button      = 5,
        on_press    = function() awful.layout.inc(1) end,
    },
}

return _M
