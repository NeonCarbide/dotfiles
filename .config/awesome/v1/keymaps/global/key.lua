local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local widgets = require("widgets")
require("awful.hotkeys_popup.keys")

local apps = require("config.apps")
local mod = require("keymaps.mod")
local keymap = awful.key

menubar.utils.terminal = apps.terminal

-- awesome
awful.keyboard.append_global_keybindings{
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "/",
        description = "Show help",
        group       = "awesome",
        on_press    = hotkeys_popup.show_help
    },
    keymap{
        modifiers   = {mod.super},
        key         = "Space",
        description = "Show main menu",
        group       = "awesome",
        on_press    = function () awful.spawn("rofi -combi-modi window,drun -show combi -modi combi") end
    },
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "Pause",
        description = "Reload awesome",
        group       = "awesome",
        on_press    = awesome.restart
    },
    keymap{
        modifiers   = {mod.super, mod.ctrl},
        key         = "/",
        description = "Quit awesome",
        group       = "awesome",
        on_press    = awesome.quit
    },
    --keymap{
    --    modifiers   = {mod.super},
    --    key         = "x",
    --    description = "Run lua code",
    --    group       = "awesome",
    --    on_press    = function ()
    --        awful.prompt.run{
    --            prompt        = "Run lua code: ",
    --            exe_callback  = awful.util.eval,
    --            history_path  = awful.util.get_cache_dir() .. "/history_eval"
    --            textbox       = awful.screen.focused().promptbox.widget
    --        }
    --    end
    --},
    keymap{
        modifiers   = {mod.super},
        key         = "Return",
        description = "Open a terminal",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.terminal) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "r",
        description = "Open run prompt",
        group       = "launcher",
        on_press    = function() awful.spawn("rofi -combi-modi window,drun -show combi -modi combi") end
    },
    keymap{
        modifiers   = {mod.super, mod.alt},
        key         = "-",
        description = "Show the menubar",
        group       = "launcher",
        on_press    = function () menubar.show() end
    },
}

-- tag related
awful.keyboard.append_global_keybindings{
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = ",",
        description = "View previous tag",
        group       = "tags",
        on_press    = awful.tag.viewprev
    },
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = ".",
        description = "View next tag",
        group       = "tags",
        on_press    = awful.tag.viewnext
    },
    keymap{
        modifiers   = {mod.super},
        key         = "Escape",
        description = "View last tag",
        group       = "tags",
        on_press    = awful.tag.history.restore
    },
}

-- tag related pt 2
for i = 1, 9 do
    local desc_view, desc_toggle, desc_move, desc_toggle_focus

    if i == 1 or i == 9 then
        desc_move           = {description = "Move focused client to tag #", group = "tags"}
        desc_toggle         = {description = "Toggle tag #", group = "tags"}
        desc_toggle_focus   = {description = "Toggle focused client on tag #", group = "tags"}
        desc_view           = {description = "View tag #", group = "tags"}
    end
    awful.keyboard.append_global_keybindings{
        keymap{
            modifiers   = {mod.super},
            key         = "#" .. i + 9,
            description = desc_view,
            group       = "awesome",
            on_press    = function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only(tag)
                end
            end
        },
        keymap{
            modifiers   = {mod.super, mod.ctrl},
            key         = "#" .. i + 9,
            description = desc_toggle,
            group       = "awesome",
            on_press    = function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:viewtoggle(tag)
                end
            end
        },
        keymap{
            modifiers   = {mod.super, mod.shift},
            key         = "#" .. i + 9,
            description = desc_move,
            group       = "awesome",
            on_press    = function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end
        },
        keymap{
            modifiers   = {mod.super, mod.ctrl, mod.shift},
            key         = "#" .. i + 9,
            description = desc_toggle_focus,
            group       = "awesome",
            on_press    = function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end
        },
    }
end

-- focus related
awful.keyboard.append_global_keybindings{
    keymap{
        modifiers   = {mod.super},
        key         = "j",
        description = "Focus next client by index",
        group       = "client",
        on_press    = function () awful.client.focus.byidx(1) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "k",
        description = "Focus previous client by index",
        group       = "client",
        on_press    = function () awful.client.focus.byidx(-1) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "Tab",
        description = "Focus last client",
        group       = "client",
        on_press    = function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end
    },
    keymap{
        modifiers   = {mod.super, mod.ctrl},
        key         = "n",
        description = "Restore minimized client",
        group       = "client",
        on_press    = function ()
            local c = awful.client.restore()
            if c then
                c:active{raise = true, context = "key.unminimize"}
            end
        end
    },
    keymap{
        modifiers   = {mod.super, mod.ctrl},
        key         = "j",
        description = "Focus next screen",
        group       = "screen",
        on_press    = function () awful.screen.focus_relative(1) end
    },
    keymap{
        modifiers   = {mod.super, mod.ctrl},
        key         = "k",
        description = "Focus previous screen",
        group       = "screen",
        on_press    = function () awful.screen.focus_relative(-1) end
    },
}

-- layout related
awful.keyboard.append_global_keybindings{
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "j",
        description = "Swap with next client by index",
        group       = "client",
        on_press    = function () awful.client.swap.byidx(1) end
    },
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "k",
        description = "Swap with previous client by index",
        group       = "client",
        on_press    = function () awful.client.swap.byidx(-1) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "u",
        description = "Jump to urgent client",
        group       = "client",
        on_press    = awful.client.urgent.jumpto
    },
    keymap{
        modifiers   = {mod.super},
        key         = "l",
        description = "Increase master width factor",
        group       = "layout",
        on_press    = function () awful.tag.incmwfact(0.05) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "h",
        description = "Decrease master width factor",
        group       = "layout",
        on_press    = function () awful.tag.incmwfact(-0.05) end
    },
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "h",
        description = "Increase the number of master clients",
        group       = "layout",
        on_press    = function () awful.tag.incnmaster(1, nil, true) end
    },
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "l",
        description = "Decrease the number of master clients",
        group       = "layout",
        on_press    = function () awful.tag.incnmaster(-1, nil, true) end
    },
    keymap{
        modifiers   = {mod.super, mod.ctrl},
        key         = "h",
        description = "Increase the number of columns",
        group       = "layout",
        on_press    = function () awful.tag.incncol(1, nil, true) end
    },
    keymap{
        modifiers   = {mod.super, mod.ctrl},
        key         = "l",
        description = "Decrease the number of columns",
        group       = "layout",
        on_press    = function () awful.tag.incncol(-1, nil, true) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "\\",
        description = "Switch to next layout",
        group       = "layout",
        on_press    = function () awful.layout.inc(1) end
    },
    keymap{
        modifiers   = {mod.super, mod.shift},
        key         = "\\",
        description = "Switch to previous layout",
        group       = "layout",
        on_press    = function () awful.layout.inc(-1) end
    },
}

-- system control
awful.keyboard.append_global_keybindings{
    keymap{
        modifiers   = {},
        key         = "XF86MonBrightnessUp",
        description = "Increase brightness by 10%",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -inc 10 -steps 6") end
    },
    keymap{
        modifiers   = {},
        key         = "XF86MonBrightnessDown",
        description = "Decrease brightness by 10%",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -dec 10 -steps 6") end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "XF86MonBrightnessUp",
        description = "Set brightness to max",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -set 100 -steps 12") end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "XF86MonBrightnessDown",
        description = "Set brightness to min",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -set 0 -steps 12") end
    },
    keymap{
        modifiers   = {},
        key         = "XF86AudioRaiseVolume",
        description = "Raise volume by 5%",
        group       = "system",
        on_press    = function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end
    },
    keymap{
        modifiers   = {},
        key         = "XF86AudioLowerVolume",
        description = "Lower volume by 5%",
        group       = "system",
        on_press    = function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end
    },
    keymap{
        modifiers   = {},
        key         = "XF86AudioMute",
        description = "Toggle mute",
        group       = "system",
        on_press    = function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end
    },
    keymap{
        modifiers   = {},
        key         = "XF86PowerOff",
        description = "Show logout screen",
        group       = "system",
        on_press    = function () _G.exit_screen_show() end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "XF86PowerOff",
        description = "Shutdown system",
        group       = "system",
        on_press    = function () awful.spawn("shutdown now") end
    },
    keymap{
        modifiers   = {mod.super, mod.alt},
        key         = "XF86PowerOff",
        description = "Reboot system",
        group       = "system",
        on_press    = function () awful.spawn("reboot") end
    },
}

-- apps
awful.keyboard.append_global_keybindings{
    keymap{
        modifiers   = {mod.super},
        key         = "b",
        description = "Open web browser",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.browser) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "e",
        description = "Open file browser",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.files) end
    },
    keymap{
        modifiers   = {mod.super},
        key         = "v",
        description = "Open editor",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.editor_cmd) end
    },
}
