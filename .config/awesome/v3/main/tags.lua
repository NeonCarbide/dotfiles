local awful = require('awful')

local rc        = {}
local layouts   = require('main.layouts')
rc.layouts      = layouts()

local _T    = {}

local tag_list  = {
    names   = { "d", "w", "c", "m", "v", "s", "g", "o", "x" },
    layouts = rc.layouts[1]
}

function _T.get ()
    local tags  = {}

    awful.screen.connect_for_each_screen(function (s)
        tags[s] = awful.tag(tag_list.names, s, tag_list.layouts)
    end)

    return tags
end

return setmetatable({}, { __call = function (_, ...) return _T.get(...) end })
