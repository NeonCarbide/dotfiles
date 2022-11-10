-- awesome_mode: api-level=4:screen=on

pcall(require, "luarocks.loader")

local beautiful = require("beautiful")
local gears = require("gears")

--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init("~/.config/awesome/theme.lua")

require("keymaps")
require("rules")
require("signals")
