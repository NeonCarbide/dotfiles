local awful = require('awful')
local gears = require('gears')

local wibox = require('wibox')

local mod   = require('bindings.mod')
local vars  = require('config.vars')

local theme = require('themes.' .. vars.theme .. '.theme')

local _M    = {}

local buttonmap = awful.button

_M.buttons = {
        buttonmap{
        modifiers = {},
        button    = 1,
        on_press  = function(t) t:view_only() end,
    },
        buttonmap{
        modifiers = {mod.super},
        button    = 1,
        on_press  = function(t)
           if client.focus then
              client.focus:move_to_tag(t)
           end
        end,
    },
        buttonmap{
        modifiers = {},
        button    = 3,
        on_press  = awful.tag.viewtoggle,
    },
        buttonmap{
        modifiers = {mod.super},
        button    = 3,
        on_press  = function(t)
           if client.focus then
              client.focus:toggle_tag(t)
           end
        end
    },
        buttonmap{
        modifiers = {},
        button    = 4,
        on_press  = function(t) awful.tag.viewprev(t.screen) end,
    },
        buttonmap{
        modifiers = {},
        button    = 5,
        on_press  = function(t) awful.tag.viewnext(t.screen) end,
    },
}

_M.layout   = {
    layout          = wibox.layout.fixed.horizontal,
    --spacing         = -12,
    --spacing_widget  = {
    --    color   = '#dddddd',
    --    shape   = gears.shape.powerline,
    --    widget  = wibox.widget.separator,
    --},
}

_M.style    = {
    --shape   = gears.shape.powerline,
}

_M.widget_template  = {
    {
        {
            {
                id      = 'text_role',
                widget  = wibox.widget.textbox,
            },
            layout  = wibox.layout.fixed.horizontal,
        },
        left    = theme.menu_height / 2,
        right   = theme.menu_height / 2,
        widget  = wibox.container.margin,
    },
    id      = 'background_role',
    widget  = wibox.container.background,
}

return _M
