-- standard awesome libraries
local awful = require('awful')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')

-- menubar library
local menubar   = require('menubar')

local _K    = {}

local mod   = require('bindings.mod')

local keymap    = awful.key

function _K.get ()
    local global_keys   = gears.table.join(
        -- awesome
        keymap({ mod.super, mod.shift }, '/', hotkeys_popup.show_help, {
                description = 'show help',
                group       = 'awesome'
            }),
        keymap({ mod.super }, 'w', function ()
                rc.mainmenu.show()
            end, {
                description = 'show main menu',
                group       = 'awesome'
            }),
        keymap({ mod.super, mod.ctrl }, 'Pause', function ()
                awesome.quit()
            end, {
                description = 'quit awesome',
                group       = 'awesome'
            }),
        keymap({ mod.super, mod.shift }, 'Pause', awesome.restart, {
                description = 'restart awesome',
                group       = 'awesome'
            }),
        keymap({ mod.super }, 'x', function ()
                awful.prompt.run {
                    exe_callback    = awful.util.eval,
                    history_path    = awful.util.get_cache_dir() .. '/history_eval',
                    prompt          = 'run lua code: ',
                    textbox         = awful.screen.focused().mypromptbox.widget
                }
            end, {
                description = 'execute lua code',
                group       = 'awesome'
            }),

        -- launcher
        keymap({ mod.super }, 'r', function ()
                awful.screen.focused().mypromptbox:run()
            end, {
                description = 'open run prompt',
                group       = 'launcher'
            }),
        keymap({ mod.super, mod.shift }, 'r', function ()
                menubar.show()
            end, {
                description = 'show the menubar',
                group       = 'launcher'
            }),

        -- tag related
        keymap({ mod.super, mod.shift }, ',', awful.tag.viewprev, {
                description = 'view previous tag',
                group       = 'tag'
            }),
        keymap({ mod.super, mod.shift }, '.', awful.tag.viewnext, {
                description = 'view next tag',
                group       = 'tag'
            }),
        keymap({ mod.super }, 'Escape', awful.tag.history.restore, {
                description = 'view last tag',
                group       = 'tag'
            }),

        -- client related
        keymap({ mod.super }, 'j', function ()
                awful.client.focus.byidx(1)
            end, {
                description = 'focus next client by index',
                group       = 'client'
            }),
        keymap({ mod.super }, 'k', function ()
                awful.client.focus.byidx(-1)
            end, {
                description = 'focus previous client by index',
                group       = 'client'
            }),
        keymap({ mod.super }, 'u', awful.client.urgent.jumpto, {
                description = 'jump to urgent client',
                group       = 'client'
            }),
        keymap({ mod.super }, 'Tab', function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end, {
                description = 'jump to last viewed client',
                group       = 'client'
            }),

        -- layout related
        keymap({ mod.super, mod.shift }, 'j', function ()
                awful.client.swap.byidx(1)
            end, {
                description = 'swap with next client by index',
                group       = 'client'
            }),
        keymap({ mod.super, mod.shift }, 'k', function ()
                awful.client.swap.byidx(-1)
            end, {
                description = 'swap with previous client by index',
                group       = 'client'
            }),
        keymap({ mod.super }, 'l', function ()
                awful.tag.incmwfact(0.05)
            end, {
                description = 'increase master width factor',
                group       = 'layout'
            }),
        keymap({ mod.super }, 'h', function ()
                awful.tag.incmwfact(-0.05)
            end, {
                description = 'decrease master width factor',
                group       = 'layout'
            }),
        keymap({ mod.super, mod.shift }, 'h', function ()
                awful.tag.incnmaster(1, nil, true)
            end, {
                description = 'increase the number of master clients',
                group       = 'layout'
            }),
        keymap({ mod.super, mod.shift }, 'l', function ()
                awful.tag.incnmaster(-1, nil, true)
            end, {
                description = 'decrease the number of master clients',
                group       = 'layout'
            }),
        keymap({ mod.super, mod.ctrl }, 'h', function ()
                awful.tag.incncol(1, nil, true)
            end, {
                description = 'increase the number of columns',
                group       = 'layout'
            }),
        keymap({ mod.super, mod.ctrl }, 'l', function ()
                awful.tag.incncol(-1, nil, true)
            end, {
                description = 'decrease the number of columns',
                group       = 'layout'
            }),
        keymap({ mod.super }, '\\', function()
                awful.layout.inc(1)
            end, {
                description = 'select next layout',
                group       = 'layout'
            }),
        keymap({ mod.super, mod.shift }, '\\', function()
                awful.layout.inc(-1)
            end, {
                description = 'select previous layout',
                group       = 'layout'
            }),

        -- screen related
        keymap({ mod.super, mod.ctrl }, 'j', function ()
                awful.screen.focus_relative(1)
            end, {
                description = 'focus the next screen',
                group       = 'screen'
            }),
        keymap({ mod.super, mod.ctrl }, 'k', function ()
                awful.screen.focus_relative(-1)
            end, {
                description = 'focus the previous screen',
                group       = 'screen'
            }),

        -- resize
        keymap({ mod.super, mod.ctrl }, 'Down', function()
                awful.client.moveresize(0, 0, 0, -20)
            end),
        keymap({ mod.super, mod.ctrl }, 'Up', function()
                awful.client.moveresize(0, 0, 0, 20)
            end),
        keymap({ mod.super, mod.ctrl }, 'Left', function()
                awful.client.moveresize(0, 0, -20, 0)
            end),
        keymap({ mod.super, mod.ctrl }, 'Right', function()
                awful.client.moveresize(0, 0, 20, 0)
            end),

        -- move
        keymap({ mod.super, mod.shift }, 'Down', function()
                awful.client.moveresize(0, -20, 0, 0)
            end),
        keymap({ mod.super, mod.shift }, 'Up', function()
                awful.client.moveresize(0, 20, 0, 0)
            end),
        keymap({ mod.super, mod.shift }, 'Left', function()
                awful.client.moveresize(-20, 0, 0, 0)
            end),
        keymap({ mod.super, mod.shift }, 'Right', function()
                awful.client.moveresize(20, 0, 0, 0)
            end)
    )

    return global_keys
end

return setmetatable({}, { __call = function (_, ...) _K.get(...) end })
