local awful = require("awful")
local modKey = require("config.keys.mod").modKey

local buttonmap = awful.button

return awful.util.table.join(
    buttonmap({}, 1, function (c)
            _G.client.focus = c
            c:raise()
        end
    ),
    buttonmap({modKey}, 1, awful.mouse.client.move,
    buttonmap({modKey}, 3, awful.mouse.client.resize,
    buttonmap({modKey}, 4, function ()
            awful.layout.inc(1)
        end
    ),
    buttonmap({modKey}, 5, function ()
            awful.layout.inc(-1)
        end
    ),
)
