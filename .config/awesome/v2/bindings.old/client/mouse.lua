local awful = require("awful")

local mod = require("bindings.mod")
local buttonmap = awful.button

client.connect_signal("request::default_mousebindings", function ()
    awful.mouse.append_client_mousebindings{
        buttonmap{
            modifiers   = {},
            button      = 1,
            on_press    = function (c) c:activate{context = "mouse_click"} end
        },
        buttonmap{
            modifiers   = {mod.super},
            button      = 1,
            on_press    = function (c)
                c:activate{
                    context = "mouse_click",
                    action  = "mouse_move"
                }
            end
        },
        buttonmap{
            modifiers   = {mod.super},
            button      = 3,
            on_press    = function (c)
                c:activate{
                    context = "mouse_click",
                    action  = "mouse_resize"
                }
            end
        },
    }
end)
