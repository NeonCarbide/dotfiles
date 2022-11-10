local awful = require'awful'
local hotkeys_popup = require'awful.hotkeys_popup'
require'awful.hotkeys_popup.keys'
local menubar = require'menubar'

local apps = require'config.apps'
local mod = require'bindings.mod'
local widgets = require'widgets'

menubar.utils.terminal = apps.terminal

-- general awesome keys
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = '/',
      description = 'show help',
      group       = 'awesome',
      on_press    = hotkeys_popup.show_help,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'space',
      description = 'show main menu',
      group       = 'awesome',
      on_press    = function() awful.spawn("rofi -combi-modi window,drun -show combi -modi combi") end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'Pause',
      description = 'reload awesome',
      group       = 'awesome',
      on_press    = awesome.restart,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'Pause',
      description = 'quit awesome',
      group       = 'awesome',
      on_press    = function () awesome.quit() end,
   },
   --awful.key{
   --   modifiers   = {mod.super},
   --   key         = 'x',
   --   description = 'lua execute prompt',
   --   group       = 'awesome',
   --   on_press    = function()
   --      awful.prompt.run{
   --         prompt = 'Run Lua code: ',
   --         textbox = awful.screen.focused().promptbox.widget,
   --         exe_callback = awful.util.eval,
   --         history_path = awful.util.get_cache_dir() .. '/history_eval'
   --      }
   --   end,
   --},
   awful.key{
      modifiers   = {mod.super},
      key         = 'Return',
      description = 'open a terminal',
      group       = 'launcher',
      on_press    = function() awful.spawn(apps.default.terminal) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'r',
      description = 'run prompt',
      group       = 'launcher',
      on_press    = function() awful.spawn("rofi -combi-modi window,drun -show combi -modi combi") end,
   },
   --awful.key{
   --   modifiers   = {mod.super},
   --   key         = 'p',
   --   description = 'show the menubar',
   --   group       = 'launcher',
   --   on_press    = function() menubar.show() end,
   --},
}

-- tags related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = ',',
      description = 'view preivous',
      group       = 'tag',
      on_press    = awful.tag.viewprev,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = '.',
      description = 'view next',
      group       = 'tag',
      on_press    = awful.tag.viewnext,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'Escape',
      description = 'go back',
      group       = 'tag',
      on_press    = awful.tag.history.restore,
   },
}

-- focus related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      key         = 'j',
      description = 'focus next by index',
      group       = 'client',
      on_press    = function() awful.client.focus.byidx(1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'k',
      description = 'focus previous by index',
      group       = 'client',
      on_press    = function() awful.client.focus.byidx(-1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'Tab',
      description = 'go back',
      group       = 'client',
      on_press    = function()
         awful.client.focus.history.previous()
         if client.focus then
            client.focus:raise()
         end
      end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'n',
      description = 'restore minimized',
      group       = 'client',
      on_press    = function()
         local c = awful.client.restore()
         if c then
            c:active{raise = true, context = 'key.unminimize'}
         end
      end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'j',
      description = 'focus the next screen',
      group       = 'screen',
      on_press    = function() awful.screen.focus_relative(1) end,
   },
}

-- layout related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'j',
      description = 'swap with next client by index',
      group       = 'client',
      on_press    = function() awful.client.swap.byidx(1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'k',
      description = 'swap with previous client by index',
      group       = 'client',
      on_press    = function() awful.client.swap.byidx(-1) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'u',
      description = 'jump to urgent client',
      group       = 'client',
      on_press    = awful.client.urgent.jumpto,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'l',
      description = 'increase master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(0.05) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'h',
      description = 'decrease master width factor',
      group       = 'layout',
      on_press    = function() awful.tag.incmwfact(-0.05) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'h',
      description = 'increase the number of master clients',
      group       = 'layout',
      on_press    = function() awful.tag.incnmaster(1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'l',
      description = 'decrease the number of master clients',
      group       = 'layout',
      on_press    = function() awful.tag.incnmaster(-1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'h',
      description = 'increase the number of columns',
      group       = 'layout',
      on_press    = function() awful.tag.incncol(1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      key         = 'l',
      description = 'decrease the number of columns',
      group       = 'layout',
      on_press    = function() awful.tag.incncol(-1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = '\\',
      description = 'select next',
      group       = 'layout',
      on_press    = function() awful.layout.inc(1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = '\\',
      description = 'select previous',
      group       = 'layout',
      on_press    = function() awful.layout.inc(-1) end,
   },
}

-- system control
awful.keyboard.append_global_keybindings{
    awful.key{
        modifiers   = {},
        key         = "XF86MonBrightnessUp",
        description = "increase brightness by 10%",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -inc 10 -steps 6") end
    },
    awful.key{
        modifiers   = {},
        key         = "XF86MonBrightnessDown",
        description = "decrease brightness by 10%",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -dec 10 -steps 6") end
    },
    awful.key{
        modifiers   = {mod.super},
        key         = "XF86MonBrightnessUp",
        description = "set brightness to max",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -set 100 -steps 12") end
    },
    awful.key{
        modifiers   = {mod.super},
        key         = "XF86MonBrightnessDown",
        description = "set brightness to min",
        group       = "system",
        on_press    = function () awful.spawn("xbacklight -set 0 -steps 12") end
    },
    awful.key{
        modifiers   = {},
        key         = "XF86AudioRaiseVolume",
        description = "raise volume by 5%",
        group       = "system",
        on_press    = function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end
    },
    awful.key{
        modifiers   = {},
        key         = "XF86AudioLowerVolume",
        description = "lower volume by 5%",
        group       = "system",
        on_press    = function () awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end
    },
    awful.key{
        modifiers   = {},
        key         = "XF86AudioMute",
        description = "toggle mute",
        group       = "system",
        on_press    = function () awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end
    },
    awful.key{
        modifiers   = {},
        key         = "XF86TouchpadToggle",
        description = "toggle touchpad",
        group       = "system",
        on_press    = function () awful.spawn("toggle-touchpad.sh") end
    },
    --awful.key{
    --    modifiers   = {mod.super, mod.shift},
    --    key         = "End",
    --    description = "show logout screen",
    --    group       = "system",
    --    on_press    = function () _G.exit_screen_show() end
    --},
    awful.key{
        modifiers   = {mod.super},
        key         = "XF86PowerOff",
        description = "shutdown system",
        group       = "system",
        on_press    = function () awful.spawn("shutdown now") end
    },
    awful.key{
        modifiers   = {mod.super, mod.alt},
        key         = "XF86PowerOff",
        description = "reboot system",
        group       = "system",
        on_press    = function () awful.spawn("reboot") end
    },
}

-- apps
awful.keyboard.append_global_keybindings{
    awful.key{
        modifiers   = {mod.super},
        key         = "b",
        description = "open web browser",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.default.browser) end
    },
    awful.key{
        modifiers   = {mod.super},
        key         = "e",
        description = "open file browser",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.default.files) end
    },
    awful.key{
        modifiers   = {mod.super},
        key         = "s",
        description = "open ncspot",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.default.terminal .. " -e ncspot") end
    },
    awful.key{
        modifiers   = {mod.super, mod.alt},
        key         = "s",
        description = "open spotify",
        group       = "launcher",
        on_press    = function () awful.spawn("spotify") end
    },
    awful.key{
        modifiers   = {mod.super},
        key         = "v",
        description = "open editor",
        group       = "launcher",
        on_press    = function () awful.spawn(apps.default.editor_cmd) end
    },
}

awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      keygroup    = 'numrow',
      description = 'only view tag',
      group       = 'tag',
      on_press    = function(index)
         local screen = awful.screen.focused()
         local tag = screen.tags[index]
         if tag then
            tag:view_only(tag)
         end
      end
   },
   awful.key{
      modifiers   = {mod.super, mod.ctrl},
      keygroup    = 'numrow',
      description = 'toggle tag',
      group       = 'tag',
      on_press    = function(index)
         local screen = awful.screen.focused()
         local tag = screen.tags[index]
         if tag then
            awful.tag.viewtoggle(tag)
         end
      end
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      keygroup    = 'numrow',
      description = 'move focused client to tag',
      group       = 'tag',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
               client.focus:move_to_tag(tag)
            end
         end
      end
   },
   awful.key {
      modifiers   = {mod.super, mod.ctrl, mod.shift},
      keygroup    = 'numrow',
      description = 'toggle focused client on tag',
      group       = 'tag',
      on_press    = function(index)
         if client.focus then
            local tag = client.focus.screen.tags[index]
            if tag then
               client.focus:toggle_tag(tag)
            end
         end
      end,
   },
   awful.key{
      modifiers   = {mod.super},
      keygroup    = 'numpad',
      description = 'select layout directly',
      group       = 'layout',
      on_press    = function(index)
         local tag = awful.screen.focused().selected_tag
         if tag then
            tag.layout = tag.layouts[index] or tag.layout
         end
      end
   },
}
