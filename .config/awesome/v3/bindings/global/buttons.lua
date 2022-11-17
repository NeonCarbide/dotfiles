local awful = require('awful')
local gears = require('gears')

local _B    = {}

local buttonmap = awful.button

function _B.get ()
    local global_buttons    = gears.table.join(
        buttonmap({}, 3, function () rc.mainmenu:toggle() end ),
        buttonmap({}, 4, awful.tag.viewnext),
        buttonmap({}, 5, awful.tag.viewprev)
    )

    return global_buttons
end

return setmetatable({}, { __call = function (_, ...) _B.get(...) end })
