local awful = require'awful'

local vars = require'config.vars'

tag.connect_signal('request::default_layouts', function()
   awful.layout.append_default_layouts(vars.layouts)
end)

--tag.connect_signal('property::layout', function(t)
--    local currentLayout = awful.tag.getproperty(t, 'layout')
--    if currentLayout == awful.layout.suit.max.fullscreen then
--        t.gap = 0
--        return
--    end
--    t.gap = 4
--end)
