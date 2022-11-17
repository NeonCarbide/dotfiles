-- standard awesome libraries
local awful = require('awful')
local gears = require('gears')

-- theming libraries
local beautiful = require('beautiful')

-- widget and layout libraries
local wibox = require('wibox')

-- local libraries
require('deco.titlebar')

local connect = client.connect_signal

connect('manage', function (c)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
            awful.placement.no_offscreen(c)
    end
end)

-- sloppy focus
--connect('mouse::enter', function (c)
--    c:emit_signal('request::activate', 'mouse_enter', { raise = false })
--end)

connect('focus', function (c)
    c.border_color  = beautiful.border_focus
end)
connect('unfocus', function (c)
    c.border_color  = beautiful.border_normal
end)
