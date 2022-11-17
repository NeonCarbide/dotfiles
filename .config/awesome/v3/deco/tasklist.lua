local awful = require('awful')
local gears = require('gears')

local _T    = {}

local buttonmap = awful.button

function _T.get ()
    local tasklist_buttons  = gears.table.join(
        buttonmap({}, 1, function (c)
                if c == client.focus then
                    c.minimized = true
                    return
                end
                c:emit_signal('request::activate', 'tasklist', { raise = true })
            end),
        buttonmap({}, 3, function ()
                awful.menu.client_list({
                    theme = { width = 250 }
                })
            end),
        buttonmap({}, 4, function ()
                awful.client.focus.byidx(1)
            end),
        buttonmap({}, 5, function ()
                awful.client.focus.byidx(-1)
            end)
    )

    return tasklist_buttons
end

return setmetatable({}, { __call = function (_, ...) _T.get(...) end})
