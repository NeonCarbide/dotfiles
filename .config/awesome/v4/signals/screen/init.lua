local awful = require'awful'
local beautiful = require'beautiful'
local wibox = require'wibox'

local vars = require'config.vars'
local widgets = require'widgets'

for s = 1, screen.count() do
    screen[s]:connect_signal('arrange', function()
        local clients   = awful.client.visible(s)
        local layout    = awful.layout.getname(awful.layout.get(s))
        if #clients > 0 then
            for _, c in pairs(clients) do
                if awful.client.floating.get(c) or layout == 'floating' then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 or layout == 'max' or layout == 'fullscreen' then
                    c.border_width = 0
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
    end)
end

screen.connect_signal('request::wallpaper', function(s)
   awful.wallpaper{
      screen = s,
      widget = {
         {
            image     = beautiful.wallpaper,
            upscale   = true,
            downscale = true,
            widget    = wibox.widget.imagebox,
         },
         valign = 'center',
         halign = 'center',
         tiled = false,
         widget = wibox.container.tile,
      }

   }
end)

screen.connect_signal('request::desktop_decoration', function(s)
   awful.tag(vars.tags, s, awful.layout.layouts[1])
   s.promptbox = widgets.create_promptbox()
   s.layoutbox = widgets.create_layoutbox(s)
   s.taglist   = widgets.create_taglist(s)
   s.tasklist  = widgets.create_tasklist(s)
   s.wibox     = widgets.create_wibox(s)
end)
