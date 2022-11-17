local awful = require('awful')
local gears = require('gears')

local wibox = require('wibox')

local _M    = {}

local buttonmap = awful.button

_M.buttons = {
    buttonmap{
        modifiers = {},
        button    = 1,
        on_press  = function(c)
            c:activate{context = 'tasklist', action = 'toggle_minimization'}
        end,
    },
    buttonmap{
        modifiers = {},
        button    = 3,
        on_press  = function() awful.menu.client_list{theme = {width = 250}}   end,
    },
    buttonmap{
        modifiers = {},
        button    = 4,
        on_press  = function() awful.client.focus.byidx(-1) end
    },
    buttonmap{
        modifiers = {},
        button    = 5,
        on_press  = function() awful.client.focus.byidx(1) end
    },
}

-- Win 10 style
--_M.layout           = {
--    spacing_widget  = {
--        {
--            color           = '#777777',
--            forced_height   = 24,
--            forced_width    = 5,
--            thickness       = 1,
--            widget          = wibox.widget.separator
--        },
--        halign          = 'center',
--        valign          = 'center',
--        widget          = wibox.container.place,
--    },
--    spacing         = 1,
--    layout          = wibox.layout.fixed.horizontal
--}

-- Documentation example
_M.layout           = {
    spacing_widget  = {
        {
            forced_width    = 5,
            shape           = gears.shape.circle,
            widget          = wibox.widget.separator
        },
        halign          = 'center',
        valign          = 'center',
        widget          = wibox.container.place,
    },
    spacing         = 16,
    layout          = wibox.layout.fixed.horizontal,
}

_M.style            = {
    --border_color    = '#777777',
    --border_width    = 1,
    shape           = gears.shape.rectangle,
}

-- Win 10 style
--_M.widget_template  = {
--    {
--        wibox.widget.base.make_widget(),
--        forced_height   = 5,
--        id              = 'background_role',
--        widget          = wibox.container.background,
--    },
--    {
--        awful.widget.clienticon,
--        margins = 5,
--        widget  = wibox.container.margin,
--    },
--    nil,
--    layout  = wibox.layout.align.vertical,
--}

-- Documentation example
_M.widget_template  = {
    {
        {
            {
                {
                    id      = 'icon_role',
                    widget  = wibox.widget.imagebox,
                },
                margins = 4,
                widget  = wibox.container.margin,
            },
            --{
            --    id      = 'text_role',
            --    widget  = wibox.widget.textbox,
            --},
            layout  = wibox.layout.fixed.horizontal,
        },
        left    = 2,
        right   = 2,
        widget  = wibox.container.margin,
    },
    id      = 'background_role',
    widget  = wibox.container.background,
}

return _M
