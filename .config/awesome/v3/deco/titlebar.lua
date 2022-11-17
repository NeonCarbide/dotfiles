-- module('anybox.titlebar', package.seeall)

local awful = require('awful')
local gears = require('gears')

local wibox = require('wibox')

local buttonmap = awful.button

client.connect_signal('request::titlebars', function (c)
    local buttons   = gears.table.join(
        buttonmap({}, 1, function ()
                c:emit_signal('request::activate', 'titlebar', { raise = true })
                awful.mouse.client.move(c)
            end),
        buttonmap({}, 3, function ()
                c:emit_signal('request::activate', 'titlebar', { raise = true })
                awful.mouse.client.resize(c)
            end)
    )

    awful.titlebar(c) : setup {
        {
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        }, {
            {
                align   = 'center',
                widget  = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        }, {
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout  = wibox.layout.fixed.horizontal
        },
        layout  = wibox.layout.align.horizontal
    }
end)
