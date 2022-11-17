pcall(require, 'luarocks.loader')

-- standard awesome libraries
local awful = require('awful')
local gears = require('gears')

-- theming libraries
local beautiful = require('beautiful')

-- miscellanious libraries
local menubar   = require('menubar')

-- initialize global namespace
local rc    = {}
rc.vars     = require('main.user-vars')

-- error handling
require('main.error-handling')

-- theme initialization
beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

-- local libraries
local main = {
    layouts = require('main.layouts'),
    menu    = require('main.menu'),
    rules   = require('main.rules'),
    tags    = require('main.tags')
}

-- load keybindings
local bindings  = {
    client_buttons  = require('bindings.client.buttons'),
    client_keys     = require('bindings.client.keys'),
    global_buttons  = require('bindings.global.buttons'),
    global_keys     = require('bindings.global.keys'),
    bind_to_tags    = require('bindings.bind-tags'),
}

-- layouts
rc.layouts  = main.layouts()

-- tags
rc.tags     = main.tags()

-- menu
rc.mainmenu = awful.menu({
    items   = main.menu()
})

rc.launcher = awful.widget.launcher({
    image   = beautiful.awesome_icon,
    menu    = rc.mainmenu
})

-- menubar configuration
menubar.utils.terminal  = rc.vars.terminal

-- key and mouse bindings
rc.global_keys  = bindings.global_keys()
rc.global_keys  = bindings.bind_to_tags(rc.global_keys)

root.buttons(bindings.global_buttons())
root.keys(rc.global_keys)

-- keyboard layout widget
mykeyboardlayout    = awful.widget.keyboardlayout()

-- statusbar
require('deco.statusbar')

-- rules
awful.rules.rules   = main.rules(
    bindings.client_buttons(),
    bindings.client_keys()
)

-- signals
require('main.signals')
