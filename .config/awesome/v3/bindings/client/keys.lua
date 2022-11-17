local awful = require('awful')
local gears = require('gears')

local _K    = {}

local mod   = require('bindings.mod')

local keymap    = awful.key

function _K.get ()
    local client_keys   = gears.table.join(
        keymap({ mod.super }, 'f', function (c)
                c.fullscreen    = not c.fullscreen
                c:raise()
            end, {
                description = 'toggle fullscreen',
                group       = 'client'
            }),
        keymap({ mod.super, mod.shift }, 'c', function (c)
                c:kill()
            end, {
                description = 'close focused client',
                group       = 'client'
            }),
        keymap({ mod.super, mod.alt }, 'f', awful.client.floating.toggle, {
                description = 'toggle floating for focused client',
                group       = 'client'
            }),
        keymap({ mod.super, mod.shift }, 'p', function (c)
                c:swap(awful.client.getmaster())
            end, {
                description = 'promote focused client to master',
                group       = 'client'
            }),
        keymap({ mod.super }, 'o', function (c)
                c:move_to_screen()
            end, {
                description = 'move client to screen',
                group       = 'client'
            }),
        keymap({ mod.super, mod.ctrl }, 'p', function (c)
                c.on_top    = not c.on_top
            end, {
                description = 'toggle keep on top for focused client',
                group       = 'client'
            }),
        keymap({ mod.super, mod.alt }, 'm', function (c)
                c.minimized = true
            end, {
                description = 'minimize focused client',
                group       = 'client'
            }),
        keymap({ mod.super, mod.alt, mod.ctrl }, 'm', function ()
                local c = awful.client.restore()
                if c then
                    c:emit_signal('request::activate', 'key.unminimize', { raise = true })
                end
            end, {
                description = 'restore minimized client',
                group       = 'client'
            }),
        keymap({ mod.super }, 'm', function (c)
                c.maximized = not c.maximized
                c:raise()
            end, {
                description = '(un)maximize focused client',
                group       = 'client'
            }),
        keymap({ mod.super, mod.ctrl }, 'm', function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end, {
                description = '(un)maximize focused client vertically',
                group       = 'client'
            }),
        keymap({ mod.super, mod.shift }, 'm', function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end, {
                description = '(un)maximize focused client horizontally',
                group       = 'client'
            })
    )

    return client_keys
end

return setmetatable({}, { __call = function (_, ...) _K.get(...) end })
