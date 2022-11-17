-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require('beautiful')

--local gears = require('gears')
--beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

local theme = require('config.vars').theme
beautiful.init('~/.config/awesome/themes/' .. theme .. '/theme.lua')

-- load key and mouse bindings
require('bindings')

-- load rules
require('rules')

-- load signals
require('signals')

-- autostart apps
require('modules.autostart')
