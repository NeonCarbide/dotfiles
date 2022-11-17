local awful = require('awful')
local gears = require('gears')

local mod   = require('bindings.mod')

local _T    = {}

local buttonmap = awful.button

function _T.get ()
    local taglist_buttons   = gears.table.join(
        buttonmap({}, 1, function (t)
                t:view_only()
            end),
        buttonmap({ mod.super }, 1, function (t)
                if client.focus then
                    client.focus:move_to_tag(t)
                end
            end),
        buttonmap({}, 3, awful.tag.viewtoggle),
        buttonmap({ mod.super }, 3, function (t)
                if client.focus then
                    client.focus:toggle_tag(t)
                end
            end),
        buttonmap({}, 4, function (t)
                awful.tag.viewnext(t.screen)
            end),
        buttonmap({}, 5, function (t)
                awful.tag.viewprev(t.screen)
            end)
    )

    return taglist_buttons
end

return setmetatable({}, { __call = function (_, ...) _T.get(...) end })
