local awful = require("awful")

local mod = require("keymaps.mod")
local keymap = awful.key

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings{
        keymap{
            modifiers   = {mod.super},
            key         = "f",
            description = "Toggle fullscreen",
            group       = "client",
            on_press    = function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end
        },
        keymap{
            modifiers   = {mod.super, mod.alt},
            key         = "f",
            description = "Toggle floating",
            group       = "client",
            on_press    = awful.client.floating.toggle
        },
        keymap{
            modifiers   = {mod.super, mod.shift},
            key         = "c",
            description = "Close focused client",
            group       = "client",
            on_press    = function (c) c:kill() end
        },
        keymap{
            modifiers   = {mod.super, mod.shift},
            key         = "p",
            description = "Promote to master stack",
            group       = "client",
            on_press    = function (c) c:swap(awful.client.getmaster()) end
        },
        keymap{
            modifiers   = {mod.super},
            key         = "o",
            description = "Move to screen",
            group       = "client",
            on_press    = function (c) c:move_to_screen() end
        },
        keymap{
            modifiers   = {mod.super, mod.alt},
            key         = "p",
            description = "Toggle keep on top",
            group       = "client",
            on_press    = function (c) c.ontop = not c.ontop end
        },
        keymap{
            modifiers   = {mod.super, mod.alt},
            key         = "m",
            description = "Minimize focused client",
            group       = "client",
            on_press    = function (c) c.minimized = true end
        },
        keymap{
            modifiers   = {mod.super},
            key         = "m",
            description = "Toggle maximize",
            group       = "client",
            on_press    = function (c)
                c.maximized = not c.maximized
                c:raise()
            end
        },
        keymap{
            modifiers   = {mod.super, mod.ctrl},
            key         = "m",
            description = "Toggle maximize vertically",
            group       = "client",
            on_press    = function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end
        },
        keymap{
            modifiers   = {mod.super, mod.shift},
            key         = "m",
            description = "Toggle maximize horizontally",
            group       = "client",
            on_press    = function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end
        },
    }
end)
