local awful = require("awful")
local widgets = require("widgets")

local buttonmap = awful.button

awful.mouse.append_global_mousebindings{
    buttonmap{
        modifiers   = {},
        button      = 3,
        on_press    = function () widgets.mainmenu:toggle() end
    },
    buttonmap{
        modifiers   = {},
        button      = 4,
        on_press    = awful.tag.viewprev
    },
    buttonmap{
        modifiers   = {},
        button      = 5,
        on_press    = awful.tag.viewnext
    },
}
