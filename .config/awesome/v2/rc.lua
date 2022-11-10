-- awesome_mode: api-level=4:screen=on

pcall(require, 'luarocks.loader')

local beautiful = require('beautiful')
--local gears = require('gears')

--beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')
--beautiful.init('~/.config/awesome/theme.lua')
beautiful.init(require('theme'))
--beautiful.init(require('theme.neon-theme'))

require('modules.autostart')
require('modules.exit-screen')

require('bindings')
require('rules')
require('signals')
