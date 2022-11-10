local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")

local apps = require("config.apps")
local mod = require("keymaps.mod")

local _W = {}

_W.awesomemenu = {
    {"hotkeys", function () hotkeys_popup.show_help(nil, awful.screen.focused()) end},
    {"edit config", apps.editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}

_W.mainmenu = awful.menu{
    items = {
        {"awesome", _W.awesomemenu, beautiful.awesome_icon},
        {"open terminal", apps.terminal}
    }
}

_W.launcher = awful.widget.launcher{
    image   = beautiful.awesome_icon,
    menu    = _W.mainmenu
}

_W.keyboardlayout = awful.widget.keyboardlayout()
_W.textclock = awful.widget.textclock()

function _W.create_promptbox() return awful.widget.prompt() end

function _W.create_layoutbox(s)
    return awful.widget.layoutbox{
        screen  = s,
        buttons = {
            awful.button{
                modifiers   = {},
                button      = 1,
                on_press    = function () awful.layout.inc(1) end
            },
            awful.button{
                modifiers   = {},
                button      = 3,
                on_press    = function () awful.layout.inc(-1) end
            },
            awful.button{
                modifiers   = {},
                button      = 4,
                on_press    = function () awful.layout.inc(1) end
            },
            awful.button{
                modifiers   = {},
                button      = 5,
                on_press    = function () awful.layout.inc(-1) end
            },
        }
    }
end

function _W.create_taglist(s)
    return awful.widget.taglist{
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button{
                modifiers   = {},
                button      = 1,
                on_press    = function (t) t:view_only() end
            },
            awful.button{
                modifiers   = {mod.super},
                button      = 1,
                on_press    = function (t)
                    if client.focus then
                        client.focus:move_to_tag(t)
                    end
                end
            },
            awful.button{
                modifiers   = {},
                button      = 3,
                on_press    = awful.tag.viewtoggle
            },
            awful.button{
                modifiers   = {mod.super},
                button      = 3,
                on_press    = function (t)
                    if client.focus then
                        client.focus:toggl_tag(t)
                    end
                end
            },
            awful.button{
                modifiers   = {},
                button      = 4,
                on_press    = function (t) awful.tag.viewprev(t.screen) end
            },
            awful.button{
                modifiers   = {},
                button      = 5,
                on_press    = function (t) awful.tag.viewnext(t.screen) end
            },
        }
    }
end

function _W.create_tasklist(s)
    return awful.widget.tasklist{
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button{
                modifiers   = {},
                button      = 1,
                on_press    = function (c)
                    c:activate{
                        context = "tasklist",
                        action = "toggle_minimization"
                    }
                end
            },
            awful.button{
                modifiers   = {},
                button      = 3,
                on_press    = function ()
                    awful.menu.client_list{
                        theme = {
                            width = 250
                        }
                    }
                end
            },
            awful.button{
                modifiers   = {},
                button      = 4,
                on_press    = function () awful.client.focus.byidx(-1) end
            },
            awful.button{
                modifiers   = {},
                button      = 5,
                on_press    = function () awful.client.focus.byidx(1) end
            },
        }
    }
end

function _W.create_wibox(s)
    return awful.wibar{
        screen      = s,
        position    = "top",
        widget      = {
            layout  = wibox.layout.align.horizontal,
            -- left
            {
                layout = wibox.layout.fixed.horizontal,
                _W.launcher,
                s.taglist,
                s.promptbox
            },
            -- middle
            {
                s.tasklist
            },
            -- right
            {
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                _W.keyboardlayout,
                _W.textclock,
                s.layoutbox
            }
        }
    }
end

return _W
