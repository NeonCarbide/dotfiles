local awful = require('awful')
local gears = require('gears')

local _B = {}

local mod   = require('bindings.mod')

local buttonmap = awful.button

function _B.get ()
    local client_buttons    = gears.table.join(
        buttonmap({}, 1, function (c)
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
        end),
        buttonmap({ mod.super }, 1, function (c)
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
            awful.mouse.client.move(c)
        end),
        buttonmap({ mod.super }, 3, function (c)
            c:emit_signal('request::activate', 'mouse_click', { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    return client_buttons
end

return setmetatable({}, { __call = function (_, ...) _B.get(...) end })
