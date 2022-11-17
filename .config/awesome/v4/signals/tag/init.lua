local awful = require'awful'

local beautiful = require'beautiful'

local vars = require'config.vars'

tag.connect_signal('request::default_layouts', function()
   awful.layout.append_default_layouts(vars.layouts)
end)
