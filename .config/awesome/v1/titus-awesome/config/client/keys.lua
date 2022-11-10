local awful = require("awful")
local modKey = require("config.keys.mod").modKey
require("awful.autofocus")

local keymap = awful.key

local clientKeys = awful.util.table.join(
    keymap({modKey}, "f", function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {
            description = "Toggle fullscreen", group = "client"
    }),
    keymap({modKey}, "c", function (c)
            c:kill()
        end, {
            description = "Close focused client", group = "client"
    }),
    keymap({modKey, "Shift"}, "p", function (c)
            c:swap(awful.client.getmaster())
        end, {
            description = "Promote client to master stack", group = "client"
    }),
)

return clientKeys
