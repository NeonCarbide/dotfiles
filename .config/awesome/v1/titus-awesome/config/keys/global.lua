local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.autofocus")

local apps = require("configuration.apps")
local altKey = require("configuration.keys.mod").altKey
local modKey = require("configuration.keys.mod").modKey

local keymap = awful.key

local globalKeys = awful.util.table.join(
    -- hotkeys
    keymap({modKey, "Shift"}, "/", hotkeys_popup.show_help, {
        description = "Show help", group = "awesome"
    }),

    --tag browsing
    keymap({modKey, "Shift"}, ".", awful.tag.viewnext, {
        description = "View next tag", group = "tags"
    }),
    keymap({modKey, "Shift"}, ",", awful.tag.viewprev, {
        description = "View previous tag", group = "tags"
    }),
    keymap({modKey}, "Escape", awful.tag.history.restore, {
        description = "View last tag", group = "tags"
    }),

    -- default client focus
    keymap({modKey}, "j", function ()
            awful.client.focus.byidx(1)
        end, {
            description = "Focus next by index", group = "client"
    }),
    keymap({modKey}, "k", function ()
            awful.client.focus.byidx(-1)
        end, {
            description = "Focus previous by index", group = "client"
    }),
    keymap({modKey, "Control"}, "n", function ()
            local c = awful.client.restore()
            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end, {
            description = "Restore minimized client", group = "client"
    }),
    keymap({modKey}, "u", awful.client.urgent.jumpto, {
        description = "Jump to urgent client", group = "client"
    }),
    keymap({modKey}, "Tab", function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, {
            description = "Jump to last client", group = "client"
    }),
    keymap({altKey}, "Tab", function ()
            awful.client.focus.byidx(1)
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end, {
            description = "Switch to next client", group = "client"
    }),
    keymap({altKey, "Shift"}, "Tab", function ()
            awful.client.focus.byidx(-1)
            if _G.client.focus then
                _G.client.focus:raise()
            end
        end, {
            description = "Switch to previous client", group = "client"
    }),

    -- layout manipulation
    keymap({modKey, "Shift"}, "j", function ()
            awful.client.swap.byidx(1)
        end, {
            description = "Swap with next client by index", group = "client"
    }),
    keymap({modKey, "Shift"}, "k", function ()
            awful.client.swap.byidx(-1)
        end, {
            description = "Swap with previous client by index", group = "client"
    }),
    keymap({modKey, "control"}, "j", function ()
            awful.screen.focus_relative(1)
        end, {
            description = "Focus the next screen", group = "screen"
    }),
    keymap({modKey, "control"}, "k", function ()
            awful.screen.focus_relative(-1)
        end, {
            description = "Focus the previous screen", group = "screen"
    }),
    keymap({modKey}, "l", function ()
            awful.tag.incmwfact(0.05)
        end, {
            description = "Increase master width factor", group = "layout"
    }),
    keymap({modKey}, "h", function ()
            awful.tag.incmwfact(-0.05)
        end, {
            description = "Decrease master width factor", group = "layout"
    }),
    keymap({modKey, "Shift"}, "h", function ()
            awful.tag.incmaster(1, nil, true)
        end, {
            description = "Increase the number of master clients", group = "layout"
    }),
    keymap({modKey, "Shift"}, "l", function ()
            awful.tag.incmaster(-1, nil, true)
        end, {
            description = "Decrease the number of master clients", group = "layout"
    }),
    keymap({modKey, "Shift"}, "h", function ()
            awful.tag.incncol(1, nil, true)
        end, {
            description = "Increase the number of columns", group = "layout"
    }),
    keymap({modKey, "Shift"}, "l", function ()
            awful.tag.incncol(-1, nil, true)
        end, {
            description = "Decrease the number of columns", group = "layout"
    }),
    keymap({modKey}, "\\", function ()
            awful.layout.inc(1)
        end,{
            description = "Select next layout", group = "layout"
    }),
    keymap({modKey, "Shift"}, "\\", function ()
            awful.layout.inc(-1)
        end,{
            description = "Select previous layout", group = "layout"
    }),

    -- standard program
    keymap({modKey}, "e", function ()
            awful.util.spawn(apps.default.files)
        end, {
            description = "Open file browser", group = "launcher"
    }),
    keymap({modKey}, "b", function ()
            awful.util.spawn(apps.default.browser)
        end, {
            description = "Open web browser", group = "launcher"
    }),
    keymap({modKey}, "Return", function ()
            awful.util.spawn(apps.default.terminal)
        end, {
            description = "Open a terminal", group = "launcher"
    }),
    keymap({modKey}, "r", function ()
            awful.spawn("rofi -combi-modi window,drun -show combi -modi combi")
        end, {
            description = "Show main menu", group = "awesome"
    }),
    keymap({modKey}, "Space", function ()
            awful.spawn("rofi -combi-modi window,drun -show combi -modi combi")
        end, {
            description = "Show main menu", group = "awesome"
    }),
    keymap({modKey, "Shift"}, "Pause", _G.awesome.restart, {
        description = "Reload awesome", group = "awesome"
    }),
    keymap({modKey, "Control"}, "Pause", _G.awesome.quit, {
        description = "Quit awesome", group = "awesome"
    }),

    -- system control
    keymap({}, "XF86MonBrightnessUp", function ()
            awful.spawn("xbacklight -inc 10 -steps 6")
        end, {
            description = "Increase brightness by 10", group = "system"
    }),
    keymap({}, "XF86MonBrightnessDown", function ()
            awful.spawn("xbacklight -dec 10 -steps 6")
        end, {
            description = "Decrease brightness by 10", group = "system"
    }),
    keymap({modKey}, "XF86MonBrightnessUp", function ()
            awful.spawn("xbacklight -set 100 -steps 12")
        end, {
            description = "Set brightness to max", group = "system"
    }),
    keymap({modKey}, "XF86MonBrightnessDown", function ()
            awful.spawn("xbacklight -set 0 -steps 12")
        end, {
            description = "Set brightness to min", group = "system"
    }),
    keymap({}, "XF86AudioRaiseVolume", function ()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
        end, {
            description = "Raise volume by 5%", group = "system"
    }),
    keymap({}, "XF86AudioLowerVolume", function ()
            awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
        end, {
            description = "Lower volume by 5%", group = "system"
    }),
    keymap({}, "XF86AudioMute", function ()
            awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        end, {
            description = "Toggle mute", group = "system"
    }),
    keymap({}, "XF86PowerOff", function ()
            _G.exit_screen_show()
        end, {
            description = "Show logout screen", group = "system"
    }),
    keymap({modKey}, "XF86PowerOff", function ()
            awful.spawn("shutdown now")
        end, {
            description = "Shutdown system", group = "system"
    }),
    keymap({modKey, altKey}, "XF86PowerOff", function ()
            awful.spawn("reboot")
        end, {
            description = "Reboot system", group = "system"
    }),
)

-- client-tag interaction
for i = 1, 9 do
    local desc_view, desc_toggle, desc_move, desc_toggle_focus

    if i == 1 or i == 9 then
        desc_view = {
            description = "View tag #", group = "tags"
        }
        desc_toggle = {
            description = "Toggle tag #", group = "tags"
        }
        desc_move = {
            description = "Move focused client to tag #", group = "tags"
        }
        desc_toggle_focus = {
            description = "Toggle focused client on tag #", group = "tags"
        }
    end

    globalKeys = awful.util.table.join(globalKeys,
        keymap({modKey}, "#" .. i + 9, function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    tag:view_only()
                end
            end, desc_view
        ),
        keymap({modKey, "Control"}, "#" .. i + 9, function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]

                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end, desc_toggle
        ),
        keymap({modKey, "Shift"}, "#" .. i + 9, function ()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]

                    if tag then
                        _G.client.focus:move_to_tag(tag)
                    end
                end
            end, desc_move
        ),
        keymap({modKey, "Control", "Shift"}, "#" .. i + 9, function ()
                if _G.client.focus then
                    local tag = _G.client.focus.screen.tags[i]

                    if tag then
                        _G.client.focus:toggle_tag(tag)
                    end
                end
            end, desc_toggle_focus
        ),
    )
end

return globalKeys

