local awful = require('awful')
local gears = require('gears')

local _B    = {}

local mod   = require('bindings.mod')

local keymap    = awful.key

function _B.get (global_keys)
    for i = 1, 9 do
        global_keys = gears.table.join(global_keys,
            keymap({ mod.super }, '#' .. i + 9, function ()
                    local screen    = awful.screen.focused()
                    local tag       = screen.tags[i]
                    if tag then
                        tag:view_only()
                    end
                end, {
                    description = 'view tag #' .. i,
                    group       = 'tag'
                }),
            keymap({ mod.super, mod.ctrl }, '#' .. i + 9, function ()
                    local screen    = awful.screen.focused()
                    local tag       = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end, {
                    description = 'toggle tag #' .. i,
                    group       = 'tag'
                }),
            keymap({ mod.super, mod.shift }, '#' .. i + 9, function ()
                    if client.focus then
                        local tag   = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end, {
                    description = 'move focused client to tag #' .. i,
                    group       = 'tag'
                }),
            keymap({ mod.super, mod.ctrl, mod.shift }, '#' .. i + 9, function ()
                    if client.focus then
                        local tag   = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end, {
                    description = 'toggle focused client on tag #' .. i,
                    group       = 'tag'
                })
        )
    end

    return global_keys
end

return setmetatable({}, { __call = function (_, ...) _B.get(...) end })
