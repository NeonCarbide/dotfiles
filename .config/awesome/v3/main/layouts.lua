local awful = require('awful')

local _L        = {}
local layout    = awful.layout.suit

function _L.get ()
    local layouts   = {
        layout.tile,
        layout.tile.bottom,
        layout.max,
        layout.max.fullscreen,
        layout.fair.horizontal,
        layout.floating
    }

    return layouts
end

return setmetatable({}, { __call = function (_, ...) return _L.get(...) end })
